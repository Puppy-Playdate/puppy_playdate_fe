class GoogleService
  def self.conn
    Faraday.new(url: "https://addressvalidation.googleapis.com/") 
  end

  def self.verify_address(address_object)
    conn.post("/v1:validateAddress?key=#{Rails.application.credentials.google[:maps_api]}") do |request|
      request.headers['Content-Type'] = 'application/json'
      request.body = address_object.to_json
    end
  end
end