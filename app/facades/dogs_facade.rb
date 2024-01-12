class DogsFacade
  attr_reader :user
  def initialize(user)
    @user = user
  end

  def dogs 
    @user.dogs
  end

  def self.create_dog(name, breed, age, size, neutered, user_id)
    response = DogsService.create_dog(name, breed, age, size, neutered, user_id)
    response_body = JSON.parse(response.body, symbolize_names: true)
    if response.status == 201
      {
        status: response.status,
        dog_id: response_body[:data][:id]
      }
    else
      {
        status: response.status,
        error: response_body[:error]
      }
    end
  end

  def self.find_dog(user_id)
    response = DogsService.find_dog(user_id)
    response[:data].map do |dog|
      Dog.new(dog)
    end
  end

  def self.find_dog_by_id(user_id, dog_id)
    response = DogsService.find_dog_by_id(user_id, dog_id)
    Dog.new(response[:data]) if response[:data]
  end

  def self.update_dog(dog_params)
    dog_object = build_dog_object(dog_params)
    response = DogsService.update_dog(dog_object)
    response_body = JSON.parse(response.body, symbolize_names: true)
    require 'pry'; binding.pry
    if response.status == 200
      {
        status: response.status,
        user_id: response_body[:data][:id]
      }
    else
      {
        status: response.status,
        error: response_body[:error]
      }
    end
  end

  private

  def self.build_dog_object(dog_params)
    bool = bool_vibes(dog_params[:neutered])
    {
      name: dog_params[:name],
      breed: dog_params[:breed],
      age: dog_params[:age].to_i,
      size: dog_params[:size].to_i,
      neutered: bool,
      user_id: dog_params[:user_id].to_i,
      id: dog_params[:id].to_i
    }
  end

  def self.bool_vibes(no_cap)
    if no_cap == "true"
      true
    else
      false
    end
  end
end