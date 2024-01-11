require 'rails_helper'

RSpec.describe DogsFacade do
  describe '#create_dog(name, breed, age, size, neutered, user_id)' do
    it 'creates a new dog object', :vcr do
      user = UsersFacade.find_user(1)
      dog_params = { name: "Loki", breed: "Pitbull", age: 4, size: "large", neutered: true, user_id: user.user_id }
      
      loki = DogsFacade.create_dog(
        dog_params[:name],
        dog_params[:breed],
        dog_params[:age],
        dog_params[:size],
        dog_params[:neutered],
        dog_params[:user_id]
      )
      
      expect(loki[:status]).to eq(201) 
      potato = DogsService.find_dog(1)

      expect(potato[:data].last).to be_a Hash
      expect(potato[:data].last[:attributes]).to be_a Hash
      expect(potato[:data].last[:attributes][:name]).to eq("Loki")
      expect(potato[:data].last[:attributes][:breed]).to eq("Pitbull")
      expect(potato[:data].last[:attributes][:age]).to eq(4)
      expect(potato[:data].last[:attributes][:size]).to eq("large")
      expect(potato[:data].last[:attributes][:neutered]).to eq(true)
    end 
  end 

  describe '#find_dog(user_id)' do
    it 'finds dogs associated with a users id', :vcr do 
      loki = DogsService.find_dog(1)

      expect(loki).to be_a Hash 
      expect(loki[:data]).to be_an Array 
      expect(loki[:data].first).to have_key(:id)
      expect(loki[:data].first).to have_key(:type)
      expect(loki[:data].first[:type]).to eq("dog")
      expect(loki[:data].first[:attributes]).to have_key(:name)
      expect(loki[:data].first[:attributes]).to have_key(:breed)
      expect(loki[:data].first[:attributes]).to have_key(:age)
      expect(loki[:data].first[:attributes]).to have_key(:size)
      expect(loki[:data].first[:attributes]).to have_key(:neutered)      
    end
  end

  describe '#update_dog(name, breed, age, size, neutered)' do 
    it 'updates a dogs information', :vcr do 
      user = UsersFacade.find_user(2)

      params = { name: "Fido", breed: "Labrador", age: 4, 
                size: "large", neutered: true, 
                user_id: user.user_id }

      old_dog = DogsFacade.create_dog(
        params[:name],
        params[:breed],
        params[:age],
        params[:size],
        params[:neutered],
        params[:user_id]
      )

      new_dog = DogsFacade.find_dog(2)
      new_params = { name: "Karl", breed: "Weiner Dog", size: "small", age: 1, neutered: true }
      dog_id = new_dog.last.dog_id
      DogsFacade.update_dog(dog_id, user.user_id, new_params[:name], new_params[:breed], new_params[:size], new_params[:age], new_params[:neutered])
      
      require 'pry'; binding.pry
      expect(new_dog[:data].last[:attributes][:name]).to_not eq("Fido")
      expect(new_dog[:data].last[:attributes][:name]).to eq("Karl")
      expect(new_dog[:data].last[:attributes][:size]).to_not eq("large")
      expect(new_dog[:data].last[:attributes][:size]).to eq("small")
    end
  end

  describe '#find_dog_by_id(user_id, dog_id)' do 
    it 'updates a dogs information', :vcr do 

    end 
  end 
end