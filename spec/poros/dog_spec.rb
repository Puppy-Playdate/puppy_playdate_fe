require 'rails_helper'

RSpec.describe Dog do 
  describe 'initialize' do 
    it 'exists with attributes' do 
      dog_data = {
        id: "13",
        type: "dog",
        attributes: {
          name: "Dusty",
          breed: "Mutt",
          age: 5,
          size: "medium",
          neutered: true
        }
      }

      dog = Dog.new(dog_data)

      expect(dog).to be_a Dog
      expect(dog.dog_id).to eq(13)
      expect(dog.name).to eq("Dusty")
      expect(dog.breed).to eq("Mutt")
      expect(dog.age).to eq(5)
      expect(dog.size).to eq("medium")
      expect(dog.neutered).to eq(true)
    end 
  end 
end 