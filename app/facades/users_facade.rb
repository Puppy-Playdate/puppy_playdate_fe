class UsersFacade
  def self.create_user(name, email, password)
    response = UsersService.create_user(name, email, password)
    response_body = JSON.parse(response.body, symbolize_names: true)
    if response.status == 201
      {
        status: response.status,
        user_id: response_body[:data][:id]
      }
    else
      {
        status: response.status,
        error: response_body[:error]
      }
    end
  end

  def self.find_user(id)
    response = UsersService.find_user(id)
    User.new(response[:data])
  end

  def self.find_by_email(email)
    response = UsersServices.find_by_email(email)
    User.new(response[:data])
  end

  def self.update_user(user, name, email, password)
    response = UsersService.update_user(user, name, email, password)
    response_body = JSON.parse(response.body, symbolize_names: true)
    if response.status == 202
      {
        status: response.status,
        user_id: response_body[:data][:id]
      }
    else
      {
        status: response.status,
        error: response_body[:error]
      }
    end
  end
end