class DogsController < ApplicationController
  def index
    @user = UsersFacade.find_user(params[:id].to_i)
    @dogs_facade = DogsFacade.find_dog(@user.user_id)
  end

  def edit
    @user = UsersFacade.find_user(params[:id])
    @dogs_facade = DogsFacade.find_dog(@user.user_id)
  end 

  def new; end

  private

  def dog_params
    params.require(:dog).permit(:name, :breed, :age, :size, :fixed)
  end
  
  def user_params
    params.permit(:name, :email, :password)
  end
end