class GoogleFacade
  def self.verify_address_and_create_social(params)
    address_object = build_address_object(params)

    address_response = GoogleService.verify_address(address_object)
    address_response_body = JSON.parse(address_response.body, symbolize_names: true)
    
    if address_response.status == 200
      social_data = build_social_object(params, address_response_body)
      create_social_and_handle_data(social_data)
    else
      # require 'pry'; binding.pry
      {
        status: address_response.status,
        error: address_response_body[:error]
      }
    end
  end

  private

  def self.build_address_object(params)
    {
      "address": {
        "regionCode": "US",
        "locality": params[:locality],
        "addressLines": params[:addressLines]
      },
      "enableUspsCass": true
    }
  end

  def self.build_social_object(params, address_response_body)
    {
      name: params[:name],
      description: params[:description],
      event_date: params[:datetime],
      event_type: params[:event_type].to_i,
      location: address_response_body[:result][:address][:formattedAddress],
      user_id: params[:user_id].to_i
    }
  end

  def self.create_social_and_handle_data(social_data)
    social_response = SocialsFacade.create_social(social_data)
    social_response_body = JSON.parse(social_response.body, symbolize_names: true)
    if social_response.status == 201
      {
        status: social_response.status,
        social_id: social_response_body[:data][:id].to_i
      }
    else
      {
        status: social_response.status,
        error: social_response_body[:error]
      }
    end
  end
end