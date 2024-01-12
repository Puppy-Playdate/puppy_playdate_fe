require 'rails_helper'

RSpec.describe DogsService do
  describe 'class methods' do
    it '#create_dog creates a new dog', :vcr do
      params = {
        name: 'Kevin',
        breed: 'Corgi',
        age: 2,
        size: "small",
        neutered: false,
        user_id: 6
      }    
      response = DogsService.create_dog(
        params[:name],
        params[:breed],
        params[:age],
        params[:size],
        params[:neutered],
        params[:user_id]
        )
      expect(response.status).to eq(201)

      dog = JSON.parse(response.body, symbolize_names: true)
      expect(dog).to be_a Hash

      kevin = dog[:data]
      expect(kevin).to have_key :id
      expect(kevin).to have_key :type
      expect(kevin[:type]).to eq("dog")
      expect(kevin).to have_key :attributes

      new_dog = kevin[:attributes]
      expect(new_dog[:name]).to eq('Kevin')
      expect(new_dog[:breed]).to eq('Corgi')
      expect(new_dog[:age]).to eq(2)
      expect(new_dog[:size]).to eq('small')
      expect(new_dog[:neutered]).to eq(false)
    end 

    it '#find_dog finds all dogs associated to a user', :vcr do
      dogs = DogsService.find_dog(7)

      expect(dogs).to be_a Hash
      expect(dogs[:data].count).to eq(12)

      loki = dogs[:data].first[:attributes]

      expect(loki).to be_a Hash
      expect(loki[:name]).to eq('Loki')
      expect(loki[:breed]).to eq('Pitbull')
      expect(loki[:age]).to eq(4)
      expect(loki[:size]).to eq('large')
      expect(loki[:neutered]).to eq(true)
    end

    it '#find_dog_by_id finds a single dog by user id and dog id', :vcr do
      dog = DogsService.find_dog_by_id(7, 11)
      
      expect(dog).to be_a Hash 
      expect(dog[:data]).to have_key :id
      expect(dog[:data]).to have_key :type
      expect(dog[:data][:type]).to eq("dog")
      expect(dog[:data]).to have_key :attributes

      akila = dog[:data][:attributes]
      
      expect(akila[:name]).to eq('Akila')
      expect(akila[:breed]).to eq('Great Pyrenees')
      expect(akila[:age]).to eq(8)
      expect(akila[:size]).to eq('large')
      expect(akila[:neutered]).to eq(true)
    end
  end 
end