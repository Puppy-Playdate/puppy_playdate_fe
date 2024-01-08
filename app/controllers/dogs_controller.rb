class DogsController < ApplicationController
  def index
    @user = UsersFacade.find_user(params[:id].to_i)
    @dogs_facade = DogsFacade.find_dog(@user.user_id)
  end

  def edit
    @user = UsersFacade.find_user(params[:id])
    @dogs_facade = DogsFacade.find_dog(@user.user_id)
  end 

  def new
  end


  def create
    @user = UsersFacade.find_user(params[:id].to_i)
    if dog_params.values.all?(&:present?)
      response = DogsFacade.create_dog(params[:name], params[:breed], params[:age], params[:size], params[:neutered])
      
      if response[:status] == 201
        redirect_to user_path(@user.user_id)
      else
        flash[:error] = "Please make sure all fields are filled in."
        redirect_back(fallback_location: add_dog_path(@user.user_id))
      end
    end
  end

  private

  def dog_params
    params.permit(:name, :breed, :age, :size, :neutered)
  end
  
  def user_params
    params.permit(:name, :email, :password)
  end
end