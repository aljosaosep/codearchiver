class SessionsController < ApplicationController
  
  def create
    user = User.authenticate(params[:login], params[:password])
    if user
      session[:user_id] = user.id
      flash[:notice] = "Logged in successfully."
      #redirect_to_target_or_default(:back)
      session[:username] = user.username
    else
      flash.now[:error] = "Invalid login or password."
      render :action => 'new'
    end
    
    redirect_to :back
  end
  
  def destroy
    session[:user_id] = nil
    flash[:notice] = "You have been logged out."
    
    redirect_to "/"
  end
end
