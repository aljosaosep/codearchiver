class UsersController < ApplicationController
  
  layout :default.to_s
  
  def new
    
    if !params[:user].nil?
      @user = User.new(params[:user])
      @user.group = 0 # set group to default
      
      if @user.save then
        #session[:user_id] = @user.id
        Profile.create(:user_id => @user.id, :email => "yes", :listing => 10)
	
        flash[:notice] = "Thank you for signing up! You are now logged in."
        redirect_to "/"
      end      
    end
    
  end
  
  
# example users/halozan #06.04.2010 14.00
  def show
    @user = User.find(:first, :conditions => {:username => params[:username]})
    @profile = Profile.find(:first, :conditions => {:user_id => @user.id} )
    @codes = Code.find(:all, :conditions => {:user_id => @user.id, 'private' => false})
   # respond_to do |format|
    #  format.html # show.html.erb
    #  format.xml  { render :xml => @profile }      
   # end
  end
  
end
