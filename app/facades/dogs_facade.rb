class DogsFacade
  def self.create_dog(name, breed, age, size, neutered)
    response = DogsService.create_dog(name, breed, age, size, neutered)
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

  def self.find_dog(id)
    response = DogsService.find_dog(id)
    Dog.new(response[:data])
  end
end