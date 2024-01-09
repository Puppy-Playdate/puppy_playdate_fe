class User
  attr_reader :name, :email, :user_id

  def initialize(data)
    # require 'pry'; binding.pry
    @user_id = data[:id].to_i
    @name = data[:attributes][:name]
    @email = data[:attributes][:email]
  end
end