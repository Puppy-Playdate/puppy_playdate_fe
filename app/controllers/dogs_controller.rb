class DogsController < ApplicationController
  def index
    @user = UsersFacade.find_user(params[:user_id].to_i)
    @dogs_facade = DogsFacade.find_dog(@user.user_id)
  end

  def edit
    @user = UsersFacade.find_user(params[:user_id].to_i)
    @dogs_facade = DogsFacade.find_dog_by_id(@user.user_id, params[:id].to_i)
  end 

  def update 
    @dogs_facade = DogsFacade.find_dog_by_id(current_user, params[:id].to_i)
    if dog_params
      response = DogsFacade.update_dog(dog_params)
      if response[:status] == 200
        flash[:success] = "Dog has been Updated!"
        redirect_to user_dogs_path(current_user)
      else
        flash[:error] = response[:error]
        redirect_back(fallback_location: edit_user_dog_path(current_user, @dogs_facade.dog_id))
      end
    else
      require 'pry'; binding.pry
      flash[:error] = "**NO FIELDS CAN BE LEFT BLANK.**"
      redirect_back(fallback_location: edit_user_dog_path(current_user, @dogs_facade.dog_id))
    end
  end

  def new
    @user = UsersFacade.find_user(params[:user_id].to_i)
  end

  def create
    @user = UsersFacade.find_user(params[:user_id].to_i)
    if dog_params
      response = DogsFacade.create_dog(params[:name], params[:breed], params[:age], params[:size], params[:neutered], @user.user_id)
      if response[:status] == 201
        redirect_to user_dogs_path(@user.user_id)
      else
        flash[:error] = "**PLEASE MAKE SURE ALL FIELDS ARE FILLED IN.**"
        redirect_back(fallback_location: new_user_dog_path(@user.user_id))
      end
    else
      flash[:error] = "**PLEASE MAKE SURE ALL FIELDS ARE FILLED IN.**"
      redirect_back(fallback_location: new_user_dog_path(@user.user_id))
    end
  end

  private

  def dog_params 
    params.permit(:name, :breed, :age, :size, :neutered, :user_id, :id)
  end
end