class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      Profile.create(:user_id => @user.id)
      flash[:notice] = "Thank you for signing up! You are now logged in."
      redirect_to new_session_path
    else
      render :action => 'new'
    end
  end
  
  
# example users/halozan #06.04.2010 14.00
  def show
    @user = User.find(:first, :conditions => {:username => params[:username]})
    @profile = Profile.find(:first, :conditions => {:user_id => @user.id} )
   # respond_to do |format|
    #  format.html # show.html.erb
    #  format.xml  { render :xml => @profile }      
   # end
  end
  
end
