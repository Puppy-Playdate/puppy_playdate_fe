class SocialsService
  def self.conn
    Faraday.new(url: "http://localhost:3000/")
  end

  def self.get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.create_social(data)
    conn.post("/api/v1/users/#{data[:user_id]}/socials") do |request|
      request.headers['Content-Type'] = 'application/json'
      request.body = data.to_json
    end
  end

  #show: a specifc social
  def self.find_social(user_id, social_id)
    get_url("/api/v1/users/#{user_id}/socials/#{social_id}")
  end

  #index: all socials
  def self.find_socials(user_id)
    get_url("/api/v1/users/#{user_id}/socials")
  end

  def self.update_social(social_object)
    conn.patch("/api/v1/users/#{social_object[:user_id]}/socials/#{social_object[:id]}") do |request|
      request.headers['Content-Type'] = 'application/json'
      request.body = social_object.to_json
    end
  end
end