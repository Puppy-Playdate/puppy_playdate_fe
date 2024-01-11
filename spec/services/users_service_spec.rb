require 'rails_helper'

RSpec.describe UsersService do
  describe 'class methods' do
    it '#find_user(id) returns a user', :vcr do
      response = UsersService.find_user(3)
      expect(response).to be_a Hash

      randall = response[:data]
      expect(randall).to have_key :id
      expect(randall[:id]).to eq("3")
      expect(randall).to have_key :type
      expect(randall[:type]).to eq("user")
      expect(randall).to have_key :attributes
      expect(randall).to have_key :relationships
      expect(randall[:relationships]).to have_key :dogs

      attributes = randall[:attributes]
      expect(attributes).to have_key :name
      expect(attributes[:name]).to eq("Randall Boggs")
      expect(attributes).to have_key :email
      expect(attributes[:email]).to eq("randy@gmail.com")
      expect(attributes).to have_key :dog_count
      expect(attributes[:dog_count]).to eq(0)
    end

    it '#find_by_email returns a user with email & password', :vcr do
      email = "randy@gmail.com"
      password = "password"
      response = UsersService.find_by_email(email, password)
      expect(response.status).to eq(200)
      
      randall = JSON.parse(response.body, symbolize_names: true)
      expect(randall).to be_a Hash

      attributes = randall[:data][:attributes]

      expect(attributes).to have_key :name
      expect(attributes[:name]).to eq("Randall Boggs")
      expect(attributes).to have_key :email
      expect(attributes[:email]).to eq("randy@gmail.com")
      expect(attributes).to have_key :dog_count
      expect(attributes[:dog_count]).to eq(0)

    end 
  end 
end 
