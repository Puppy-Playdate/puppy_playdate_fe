class User
  attr_reader :name, :email, :user_id, :uid, :oauth_token

  def initialize(data)
    # require 'pry'; binding.pry
    @user_id = data[:id].to_i
    @name = data[:attributes][:name]
    @email = data[:attributes][:email]
    @uid = data[:attributes][:uid]
    @oauth_token = data[:attributes][:oauth_token]
  end
end