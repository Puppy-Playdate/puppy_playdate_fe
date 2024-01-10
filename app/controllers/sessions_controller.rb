class SessionsController < ApplicationController
  def create
    # require 'pry'; binding.pry
    client_id = "1bb80c73f29664e63ddf"
    client_secret = "87ce605d17840a01d49c6a3eb1a104e47ba74d2b"
    code = params[:code] # "code"=>"639935e066b55a4d3124
    
    conn = Faraday.new(url: 'https://github.com', headers: {'Accept': 'application/json'})
    
    response = conn.post('/login/oauth/access_token') do |req|
      req.params['code'] = code
      req.params['client_id'] = client_id
      req.params['client_secret'] = client_secret
    end
    # require 'pry'; binding.pry
    
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
      
      user = user_facade.github_oauth(
      {
        uid: data[:id],
        email: data[:email],
        access_token: access_token
      }
    )

    session[:user_id] = user.id
    redirect_to user_path(user.id)
  end

  def user_facade
    UserFacade.new(params[:id])
  end
end