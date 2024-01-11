require "rails_helper"

describe UsersService do
  describe "Class methods" do  
    describe "#github_auth" do
      xit "returns user from github login", :vcr do
        user = Users.new.github_oauth({
          email: "jamespsullivan@wahoo.com",
          uid: "32145678",
          access_token: "87ce605d17840a01d49c6a3eb1a104e47ba74d2"
        }
        )

        expect(user).to be_a(Hash)

        expect(user[:data]).to have_key(:id)
        expect(user[:data][:id]).to be_a(String)

        expect(user[:data][:attributes]).to have_key(:uid)
        expect(user[:data][:attributes][:uid]).to be_a(String)

        expect(user[:data][:attributes]).to have_key(:email)
        expect(user[:data][:attributes][:email]).to be_a(String)

        expect(user[:data][:attributes]).to have_key(:auth_token)
        expect(user[:data][:attributes][:auth_token]).to be_a(String)
      end
    end
  end
end 