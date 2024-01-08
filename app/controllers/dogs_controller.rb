class DogsController < ApplicationController
  def index
    @user = UsersFacade.find_user(params[:id].to_i)
    @dogs_facade = DogsFacade.find_dog(@user.user_id)
  end



  private

  def dog_params
    params.require(:dog).permit(:name, :breed, :age, :size, :fixed)
  end
  
  def user_params
    params.permit(:name, :email, :password)
  end
end