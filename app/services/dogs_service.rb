class DogsService
  def self.conn
    Faraday.new(url: Rails.configuration.x.sessions_service_url)
  end
  
  def self.get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end  

  def self.find_dog(user_id)
    get_url("/api/v1/users/#{user_id}/dogs")
  end

  def self.find_dog_by_id(user_id, dog_id)
    get_url("/api/v1/users/#{user_id}/dogs/#{dog_id}")
  end

  def self.create_dog(name, breed, age, size, neutered, user_id)
    conn.post("/api/v1/users/#{user_id}/dogs") do |request|
      request.headers['Content-Type'] = 'application/json'
      request.body = { name: name, breed: breed, age: age, size: size, neutered: neutered }.to_json
    end
  end

  def self.update_dog(name, breed, age, size, neutered, user_id, dog_id)
    conn.patch("/api/v1/users/#{user_id}/dogs/#{dog_id}") do |request|
      request.headers['Content-Type'] = 'application/json'
      request.body = { name: name, breed: breed, age: age, size: size, neutered: neutered }.to_json
    end
  end
end