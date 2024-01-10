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

  def self.update_dog(name, breed, age, size, neutered, user_id, dog_id)
    response = DogsService.update_dog(name, breed, age, size, neutered, user_id, dog_id)
    response_body = JSON.parse(response.body, symbolize_names: true)
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
end