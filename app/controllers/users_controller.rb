class UsersController < ApplicationController
  def show 
    @user = UserFacade.get_by_id(params[:id])
  end

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

  def edit
    user_attr = UserFacade.get_by_id(params[:id])
    @user = UserDecorator.new(user_attr)
  end 

  def update  
    require 'pry'; binding.pry
    @user = UserFacade.get_by_id(params[:id])
    @user.update(user_params)
  end

  private 

  # def user_params
  #   params.require(:user).permit(:name, :email, :password) 
  # end
end
