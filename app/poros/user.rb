class User
  attr_reader :name, :email, :user_id

  def initialize(data)
    @user_id = data[:id].to_i
    @name = data[:attributes][:name]
    @email = data[:attributes][:email]
  end
end