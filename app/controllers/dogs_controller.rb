class DogsController < ApplicationController
  def index
    @user = UsersFacade.find_user(params[:user_id].to_i)
    @dogs_facade = DogsFacade.find_dog(@user.user_id)
    #require 'pry'; binding.pry

  end

  def edit
    @user = UsersFacade.find_user(params[:user_id].to_i)
    @dogs_facade = DogsFacade.find_dog_by_id(@user.user_id, params[:id].to_i)
    # require 'pry'; binding.pry
  end 

  def update 
    @user = UsersFacade.find_user(params[:user_id].to_i)
    @dogs_facade = DogsFacade.find_dog_by_id(@user.user_id, params[:id].to_i)
    
    if required_fields_present?
      response = DogsFacade.update_dog(params[:name], params[:breed], params[:age], params[:size], params[:neutered], @user.user_id, @dogs_facade.dog_id)
      # require 'pry'; binding.pry
      if response[:status] == 200
        redirect_to user_dogs_path(@user.user_id)
      else
        flash[:error] = "**NO FIELDS CAN BE LEFT BLANK.**"
        redirect_back(fallback_location: edit_user_dog_path(@user.user_id, @dogs_facade.dog_id))
      end
    else
      flash[:error] = "**NO FIELDS CAN BE LEFT BLANK.**"
      redirect_back(fallback_location: edit_user_dog_path(@user.user_id, @dogs_facade.dog_id))
    end
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
    params.permit(:name, :breed, :age, :size, :neutered, :user_id)
  end

  def required_fields_present?
    required_params = [:name, :breed, :age, :size, :neutered, :user_id]
    required_params.all? { |param| params[param].present? }
  end
  
  def user_params
    params.permit(:name, :email, :password)
  end
end