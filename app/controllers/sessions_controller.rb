class SessionsController < ApplicationController
  def create
    client_id = "aae04c62b896b4d08290"
    client_secret = "c50b2f9533becbbbfd2f87ea444c9c908b691f51"
    code = params[:code]
    conn = Faraday.new(url: 'https://github.com', headers: {'Accept': 'application/json'})
    
    response = conn.post('/login/oauth/access_token') do |req|
      req.params['code'] = code
      req.params['client_id'] = client_id
      req.params['client_secret'] = client_secret
    end
    require 'pry'; binding.pry
    
    data = JSON.parse(response.body, symbolize_names: true)
    access_token = data[:access_token]
    
    conn = Faraday.new(
    url: 'https://api.github.com',
    headers: {
        'Authorization': "token #{access_token}"
      }
    )
    response = conn.get('/user')
    data = JSON.parse(response.body, symbolize_names: true)
require 'pry'; binding.pry
  end
end