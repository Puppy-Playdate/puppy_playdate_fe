class UsersService
  def self.conn
    Faraday.new(url: "http://localhost:3000/")
  end
  
  def self.get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.find_user(id)
    get_url("/api/v1/users/#{id}")
  end

  def self.find_by_email(email, pass)
    # require 'pry'; binding.pry
    conn.get("/api/v1/find_by_email") do |request|
      request.headers['Content-Type'] = 'application/json'
      request.body = { email: email, pass: pass }.to_json
    end
  end

  def self.create_user(name, email, password)
    conn.post("/api/v1/users") do |request|
      request.headers['Content-Type'] = 'application/json'
      request.body = { name: name, email: email, password: password }.to_json
    end
  end
end