class LoginController < ApplicationController
  skip_before_action :authenticate_user, :authenticate_admin

  
  
  def new
    
  end
  

  def create
    user = User.find_by(email: params[:email], password: params[:password])
    
    if user.present?
     session[:user_id] = user.id
     redirect_to root_path
     flash[:notice] = "Welcome #{ user.display_name }"
    else 
      flash[:alert] = "Email or password is incorrect"
      redirect_to action: :new
    end
   
  end
  
  def destroy
    session[:user_id] = nil
    flash[:notice] = "You have successfully log out"
    redirect_to login_path
  end
    
  
  
end
