class GoogleFacade
  def self.verify_address_and_create_social(params)
    address_object = build_address_object(params)

    if address_object[:status] == 422
      {
        status: address_object[:status],
        error: address_object[:error]
      }
    else
      address_response = GoogleService.verify_address(address_object)
      # require 'pry'; binding.pry
      address_response_body = JSON.parse(address_response.body, symbolize_names: true)
      if address_response.status == 200
        social_data = build_social_object(params, address_response_body)
        create_social_and_handle_data(social_data)
      else
        {
          status: address_response.status,
          error: address_response_body[:error]
        }
      end
    end
  end

  private

  def self.build_address_object(params)
    if params[:locality].blank?
      {
        status: 422,
        error: "City and address must be filled in"
      }
    else
      {
        "address": {
          "regionCode": "US",
          "locality": params[:locality],
          "addressLines": params[:addressLines]
        },
        "enableUspsCass": true
      }
    end
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
    if social_response[:status] == 201
      {
        status: social_response[:status],
        social_id: social_response[:social_id].to_i
      }
    else
      # require 'pry'; binding.pry
      {
        status: social_response[:status],
        error: social_response[:error]
      }
    end
  end
end