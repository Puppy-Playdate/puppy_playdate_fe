require 'rails_helper'

RSpec.describe User do 
  describe 'initialize' do 
    it 'exists with attributes' do 
      user_data = {
        id: "42",
        type: "user",
        attributes: {
          name: "Bianca Snyder",
          email: "queenB@yahoo.com",
        }
      }

      user = User.new(user_data)

      expect(user).to be_a User
      expect(user.user_id).to eq(42)
      expect(user.name).to eq("Bianca Snyder")
      expect(user.email).to eq("queenB@yahoo.com")
    end 
  end 
end 