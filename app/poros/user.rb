class User
  attr_reader :name, :email

  def initialize(data)
    @name = data[:attributes][:name]
    @email = data[:attributes][:email]
  end
end