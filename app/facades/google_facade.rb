class GoogleFacade
  def self.verify_address_and_create_social(params)
    address_object = build_address_object(params)

    address_response = GoogleService.verify_address(address_object)
    # Line below is only needed in order to build social object
    response_body = JSON.parse(address_response.body, symbolize_names: true)

    require 'pry'; binding.pry
    # if address_response.status == 200
    #   social_response = SocialsFacade.create_social(data)
    #   if social_response.status == 201
    #     flash[:success] = "Social Created"
    #   else
    #     flash[:error] = social_response[:error]
    #   end
    # else
    #   flash[:error] = address_response[:error]
    # end
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

  def self.build_social_object(params, response_body)
    {
      name: params[:name],
      date: params[:date],
      time:[params["[time(4i)]"], params["[time(5i)]"]].join(":"),
      location: response_body[:result][:address][:formattedAddress]
    }
  end
end