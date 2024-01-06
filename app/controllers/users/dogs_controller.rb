class Users::DogsController < ApplicationController
  def index
    @user = UsersFacade.find_user(params[:id])
    @dogs = @user.dogs.all
  end

  def create
    @user = UsersFacade.find_user(params[:id])
    @dog = @user.dogs.new(dog_params)
  end

  private

  def dog_params
    params.require(:dog).permit(:name, :breed, :age, :size, :fixed)
  end
  
end