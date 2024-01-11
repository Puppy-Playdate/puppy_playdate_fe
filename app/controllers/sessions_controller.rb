class SessionsController < ApplicationController
  def create
    auth_hash = request.env["omniauth.auth"]
    uid = auth_hash.uid
    name = auth_hash.info['name']
    # require 'pry'; binding.pry
    @user = UsersFacade.github_oauth(auth_hash)
    # binding.b
    if @user != nil
      session[:user_id] = @user.user_id
      redirect_to user_path(@user.user_id)
    else
      redirect_to login_path
    end
  end
end