class Users::DogsController < ApplicationController
  def index
    @user = UsersFacade.find_user(params[:id])
    @dogs = DogsFacade.new(user: @user)
  end



  private

  def dog_params
    params.require(:dog).permit(:name, :breed, :age, :size, :fixed)
  end
  
end