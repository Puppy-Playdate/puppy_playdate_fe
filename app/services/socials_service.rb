class SocialsService
  def self.conn
    Faraday.new(url: "http://localhost:3000/")
  end

  def self.get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.create_social(data)
    conn.post("/api/v1/socials") do |request|
      request.headers['Content-Type'] = 'application/json'
      request.body = data.to_json
    end
  end
end