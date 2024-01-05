class UsersFacade
  def self.create_user(name, email, password)
    response = UsersService.create_user(name, email, password)
    response_body = JSON.parse(response.body, symbolize_names: true)
    User.new(response_body[:data])
  end

  def self.find_user(id)
    response = UsersService.find_user(id)
    User.new(response[:data])
    # require 'pry'; binding.pry
  end
end