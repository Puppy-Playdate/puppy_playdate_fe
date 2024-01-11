require 'rails_helper'

RSpec.describe UsersFacade do
  describe '#create_user(name, email, password)' do
    it 'creates a new user object', :vcr do 
      params = { name: "Justin Winchester", email: "up_dog@yahoo.com", password: "puppy" }
      justin = UsersFacade.create_user(
        params[:name],
        params[:email],
        params[:password]
      )

      expect(justin[:status]).to eq(201)
      expect(justin).to have_key(:user_id)
    end
  end

  describe '#find_user(id)' do 
    it 'finds a user by its id', :vcr do 

    end
  end

  describe '#find_by_email(email, pass)' do 
    it 'finds a user by its email and password', :vcr do 

    end
  end

  describe '#update_user(user, name, email, password)' do 
    it 'updates a users information', :vcr do 

    end
  end
end