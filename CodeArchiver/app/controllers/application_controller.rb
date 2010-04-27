# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include Authentication
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
        @id = User.find(:first, :conditions => {:id => session[:user_id]}).id #Profile.find(params[:id])

        unless isCurrentUserAdmin(@id) #User.find_by_id(session[:user_id])
  	  flash[:notice] = "You are not authorized to do that." 
  	   redirect_to :controller => 'main', :action => 'error404'
        end
     end

  #protected
     #def authorize
        #unless User.find_by_id(session[:user_id])
	#   flash[:notice] = "Please log in."
	#   redirect_to :controller => 'sessions', :action => 'create'
        #end
     #end
end
