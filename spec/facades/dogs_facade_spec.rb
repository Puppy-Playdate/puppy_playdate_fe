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

      old_params = { name: "Fido", breed: "Labrador", age: 4, 
                size: "large", neutered: true, 
                user_id: user.user_id }

      old_dog = DogsFacade.create_dog(
        old_params[:name],
        old_params[:breed],
        old_params[:age],
        old_params[:size],
        old_params[:neutered],
        old_params[:user_id]
      )

      fido = DogsFacade.find_dog_by_id(user.user_id, old_dog[:dog_id].to_i)
      new_params = { name: "Karl", breed: "Weiner Dog", size: "small", age: 1, neutered: true }

      dog_params = {
        user_id: user.user_id,
        id: fido.dog_id,
        name:  new_params[:name],
        breed: new_params[:breed],
        size: new_params[:size],
        age: new_params[:age],
        neutered: new_params[:neutered]
      }

      response = DogsFacade.update_dog(dog_params)

      karl = DogsFacade.find_dog_by_id(user.user_id, fido.dog_id)

      expect(karl.name).to_not eq("Fido")
      expect(karl.name).to eq("Karl")
      expect(karl.size).to_not eq("large")
      expect(karl.size).to eq("small")
      expect(karl.age).to_not eq(4)
      expect(karl.age).to eq(1)
      expect(karl.breed).to_not eq("Labrador")
      expect(karl.breed).to eq("Weiner Dog")
    end
  end

  describe '#find_dog_by_id(user_id, dog_id)' do 
    it 'updates a dogs information', :vcr do 

    end 
  end 
end