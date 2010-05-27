class SessionsController < ApplicationController
  
  def create
    user = User.authenticate(params[:login], params[:password])
    if user
      session[:user_id] = user.id
      flash[:notice] = "Logged in successfully."
      #redirect_to_target_or_default(:back)
      session[:username] = user.username
      redirect_to :back
    else
      flash.now[:error] = "Invalid login or password."
      #redirect_to :back
       redirect_to "/login_error"
      #render :action => 'new'
    end
    
    #redirect_to :back
  end
  
  def destroy
    session[:user_id] = nil
    flash[:notice] = "You have been logged out."
    
    redirect_to "/"
  end
end
