class UsersController < ApplicationController
  def login_form;end 

  def login_user
    user = User.find_by(email: params[:email])

    if user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.name}!"
      redirect_to user_path(user)  
    else
      flash[:error] = "Sorry, your credentials are bad."
      render :login_form    
    end  
  end
end
