class SessionsController < ApplicationController
  def create
    auth_hash = request.env["omniauth.auth"]
    uid = auth_hash.uid
    name = auth_hash.info['name']
    @user = UsersFacade.github_oauth(params)
    # binding.b
    if @user.persisted?
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else
      redirect_to login_path
    end
  end
end