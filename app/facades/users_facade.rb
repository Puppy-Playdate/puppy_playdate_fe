class UsersFacade
  def self.create_user(name, email, password)
    response = UsersService.create_user(name, email, password)
    response_body = JSON.parse(response.body, symbolize_names: true)
    User.new(response_body[:data])
  end
end