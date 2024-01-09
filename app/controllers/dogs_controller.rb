class DogsController < ApplicationController
  def index
    
    @user = UsersFacade.find_user(params[:user_id].to_i)
    @dogs_facade = DogsFacade.find_dog(@user.user_id)
  end

  def edit
    @user = UsersFacade.find_user(params[:user_id])
    @dogs_facade = DogsFacade.find_dog(@user.user_id)
  end 

  def new
    @user = UsersFacade.find_user(params[:user_id].to_i)
  end


  def create
    @user = UsersFacade.find_user(params[:user_id].to_i)
    if required_fields_present?
      response = DogsFacade.create_dog(params[:name], params[:breed], params[:age], params[:size], params[:neutered], @user.user_id)
      
      if response[:status] == 201
        redirect_to user_dogs_path(@user.user_id)
      else
        flash[:error] = "Please make sure all fields are filled in."
        redirect_back(fallback_location: new_user_dog_path(@user.user_id))
      end
    else
      flash[:error] = "Please make sure all fields are filled in."
      redirect_back(fallback_location: new_user_dog_path(@user.user_id))
    end
  end

  private

  def required_fields_present?
    required_params = [:name, :breed, :age, :size, :neutered]
    required_params.all? { |param| params[param].present? }
  end
  
  def user_params
    params.permit(:name, :email, :password)
  end
end