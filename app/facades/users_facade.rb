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
    # require 'pry'; binding.pry
    User.new(response[:data])
  end

  def self.find_by_email(email, pass)
    response = UsersService.find_by_email(email, pass)
    response_body = JSON.parse(response.body, symbolize_names: true)
    if response.status == 200
      User.new(response_body[:data])
    else
      AuthenticationError.new(response_body)
    end
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

  def self.github_oauth(params)
    # require 'pry'; binding.pry
    response = UsersService.github_oauth(params)

    if response[:data]
      User.new(response[:data])
    else
      { error: response[:error] }
    end
  end 
end