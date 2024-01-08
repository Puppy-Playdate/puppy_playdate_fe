class GoogleFacade
  def self.verify_address(address, social)
    address_object =  {
      "address": {
        "regionCode": "US",
        "locality": params[:locality],
        "addressLines": [ params[:addressLines]]
      },
      "enableUspsCass": true
    }
    require 'pry'; binding.pry

    # address_response = GoogleService.verify_address(address_object)
    # response_body = JSON.parse(response.body, symbolize_names: true)
    if address_response.status == 200
      social_response = SocialsFacade.create_social(data)
      if social_response.status == 201
        flash[:success] = "Social Created"
      else
        flash[:error] = social_response[:error]
      end
    else
      flash[:error] = address_response[:error]
    end


    require 'pry'; binding.pry
  end
end