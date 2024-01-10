require 'rails_helper'

RSpec.describe DogsFacade do
  describe '#create_dog(name, breed, age, size, neutered, user_id)' do
    it 'creates a new dog object', :vcr do
      user = UsersFacade.find_user(1)
      dog_params = {name: "Loki", breed: "Pitbull", age: 4, size: "large", neutered: true, user_id: user.user_id}
      
      loki = DogsFacade.create_dog(
        dog_params[:name],
        dog_params[:breed],
        dog_params[:age],
        dog_params[:size],
        dog_params[:neutered],
        dog_params[:user_id]
      )
      expect(loki[:status]).to eq(201) 
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
      
    end
  end
end