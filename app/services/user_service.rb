class UserService 
  def self.find_by_id(id)
    get_url("/api/v1/users/#{id}")
  end

  def self.conn 
    conn = Faraday.new('http://localhost:3000')
  end

  private 

  def self.get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end