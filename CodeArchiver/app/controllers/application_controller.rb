# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include Authentication
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  #before_filter :authorize, :except => :login
  #debugger
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  # default authentication for filtering: authorize only admin group
  protected
     def authorize
	unless session[:user_id] == nil # First check if user is logged in at all
        	@id = User.find(:first, :conditions => {:id => session[:user_id]}).id 

		# User is logged in; check wheter he is admin or not
        	unless isCurrentUserAdmin(@id) # User is not an admin!
  	  		flash[:notice] = "You are not authorized to do that." 
  	  		redirect_to :controller => 'main', :action => 'error404'
        	end
	else
			# User is not logged in. Redirect him to login form.
	  	  	flash[:notice] = "This action must be authorised." 
  	  		redirect_to :controller => 'main', :action => 'error404'
	end
     end


    # Requires only user to be logged in.
    def loggedin
	if session[:user_id] == nil # In case user is not logged in ...
		# ... redirect him somewhere. We dont want him to mess with comments
	  	flash[:notice] = "This action must be authorised." 
  	  	redirect_to :controller => 'main', :action => 'error404'
	end
     end
end
