class UsersController < ApplicationController
  def login_form;end 

  def login_user
    # require 'pry'; binding.pry
    # Not a real endpoint/ Facade yet
    # require 'pry'; binding.pry
    user = UsersFacade.find_by_email(params[:email], params[:password])
    require 'pry'; binding.pry

    if user.name
      session[:user_id] = user.user_id
      flash[:success] = "Welcome #{user.name}!"
      redirect_to user_path(current_user)
    else
      flash[:error] = "Sorry, your credentials are bad"
      redirect_back(fallback_location: login_path)
    end
    # if user.authenticate(params[:password])
    #   session[:user_id] = user.id
    #   flash[:success] = "Welcome, #{user.name}!"
    #   redirect_to user_path(user)  
    # else
    #   flash[:error] = "Sorry, your credentials are bad."
    #   render :login_form    
    # end  
  end

  def edit
    @user = UsersFacade.find_user(params[:id])
  end 

  def update
    if params[:password] == params[:password_confirmation]
      user = UsersFacade.find_user(params[:id].to_i)
      response = UsersFacade.update_user(user, params[:name], params[:email], params[:password])
      session[:user_id] = response[:user_id].to_i
      if response[:status] == 202
        flash[:success] = "Profile Updated"
        redirect_to user_path(current_user)
      else
        flash[:error] = response[:error].join(', ')
        redirect_back(fallback_location: edit_user_path(current_user))
      end
    else
      session[:user_id] = params[:id]
      flash[:error] = "Passwords Must Match"
      redirect_back(fallback_location: edit_user_path(current_user))
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
    @user = UsersFacade.find_user(params[:id])
  end

  private

  def user_params
    params.permit(:name, :email, :password)
  end
end
