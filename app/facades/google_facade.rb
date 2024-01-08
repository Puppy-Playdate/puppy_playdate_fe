class GoogleFacade
  def self.verify_address(params)
    address_object =  {
      "address": {
        "regionCode": "US",
        "locality": params[:locality],
        "addressLines": params[:addressLines]
      },
      "enableUspsCass": true
    }
    
    address_response = GoogleService.verify_address(address_object)
    response_body = JSON.parse(address_response.body, symbolize_names: true)

    social_data = {
      name: params[:name],
      date: params[:date],
      time: social[:time].join(":"),
      location: response_body[:result][:address][:formattedAddress]
    }

    require 'pry'; binding.pry
    if address_response.status == 200
      # social_response = SocialsFacade.create_social(data)
      if social_response.status == 201
        flash[:success] = "Social Created"
      else
        flash[:error] = social_response[:error]
      end
    else
      flash[:error] = address_response[:error]
    end
  end
end