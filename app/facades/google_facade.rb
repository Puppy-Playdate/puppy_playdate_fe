class GoogleFacade
  def self.verify_address_and_create_social(params)
    address_object = build_address_object(params)

    address_response = GoogleService.verify_address(address_object)
    address_response_body = JSON.parse(address_response.body, symbolize_names: true)

    if address_response.status == 200
      social_data = build_social_object(params, address_response_body)
      create_social_and_handle_data(social_data)
    else
      return flash[:error] = address_response[:error]
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
      date: params[:date],
      time:[params["[time(4i)]"], params["[time(5i)]"]].join(":"),
      location: address_response_body[:result][:address][:formattedAddress]
    }
  end

  def self.create_social_and_handle_data(social_data)
    social_response = SocialsFacade.create_social(social_data)
    if social_response.status == 201
      return flash[:success] = "Social Created"
    else
      return flash[:error] = social_response[:error]
    end
  end
end