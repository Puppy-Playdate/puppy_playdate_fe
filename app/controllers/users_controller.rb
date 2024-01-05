class UsersController < ApplicationController
  def login_form;end 

  def login_user
    require 'pry'; binding.pry
    user = UsersFacade.find_by_email(params[:email])

    if user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.name}!"
      redirect_to user_path(user)  
    else
      flash[:error] = "Sorry, your credentials are bad."
      render :login_form    
    end  
  end

  def log_out
    session.clear
    redirect_to root_path
  end

  def new;end

  def create
    if params[:password] == params[:password_confirmation]
      response = UsersFacade.create_user(params[:name], params[:email], params[:password])
      if response[:status] == 201
        flash[:success] = "Account Created"
        session[:user_id] = response[:user_id].to_i
        redirect_to user_path(current_user)
      else
        flash[:error] = response[:error].join(', ')
        redirect_back(fallback_location: new_user_path)
      end       
    else
      flash[:error] = "Passwords Must Match"
      redirect_back(fallback_location: new_user_path)
    end
  end

  def show
    @user = UsersFacade.find_user(current_user)
  end
end
