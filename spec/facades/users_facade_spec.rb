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
      justin = UsersFacade.find_user(7)
      expect(justin).to be_a User
      expect(justin.name).to eq("Justin Winchester")
      expect(justin.email).to eq("up_dog@yahoo.com")
      expect(justin.user_id).to eq(7)
    end
  end

  describe '#find_by_email(email, pass)' do 
    it 'finds a user by its email and password', :vcr do 
      params = { email: "up_dog@yahoo.com", password: "puppy" }
      justin = UsersFacade.find_by_email(
        params[:email],
        params[:password]
      )

      expect(justin).to be_a User 
      expect(justin.name).to eq("Justin Winchester")
      expect(justin.email).to eq("up_dog@yahoo.com")
    end
  end

  describe '#update_user(user, name, email, password)' do 
    it 'updates a users information', :vcr do 
      justin = UsersFacade.find_user(7)
      params = { name: "Justin P. Sherman", email: "up_dog@gmail.com", password: "puppy123" }

      justin_update = UsersFacade.update_user(justin, params[:name], params[:email], params[:password])
      new_justin = UsersFacade.find_user(7)

      expect(new_justin.name).to_not eq("Justin Winchester")
      expect(new_justin.name).to eq("Justin P. Sherman")
      expect(new_justin.email).to_not eq("up_dog@yahoo.com")
      expect(new_justin.email).to eq("up_dog@gmail.com")
    end
  end
end