require 'rails_helper'

RSpec.describe AuthenticationError do 
  describe 'initialize' do 
    it 'exists with attributes' do 
      error_data = {
        name: false,
        status: 401,
        error: "Sorry, your credentials are bad"
      }

      auth_error = AuthenticationError.new(error_data)

      expect(auth_error).to be_a AuthenticationError
      expect(auth_error.name).to eq(false)
      expect(auth_error.status).to eq(401)
      expect(auth_error.error).to eq("Sorry, your credentials are bad")
    end 
  end 
end 