class User
  attr_reader :name, :email, :user_id, :uid

  def initialize(data)
    @user_id = data[:id].to_i
    @name = data[:attributes][:name]
    @email = data[:attributes][:email]
    @uid = data[:attributes][:uid]
  end
end