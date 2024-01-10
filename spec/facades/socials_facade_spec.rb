require 'rails_helper'

RSpec.describe SocialsFacade do
  describe '#create_social(data)' do
    it 'creates a new social object', :vcr do 
      user = UsersFacade.find_user(2)

      social_params = ({
        name: 'Wine with Weenies',
        description: 'Wine with Weenies is a social event for Weiner Dog owners to meet and mingle with other Weiner Dog owners.',
        location: 'Denver, CO',
        event_date: Date.today,
        event_type: 'chill',
        user_id: user.user_id
      })

      response = SocialsFacade.create_social(social_params)
      weenies = JSON.parse(response.body, symbolize_names: true)

      social = weenies[:data]
      expect(social).to be_a Hash
      expect(social).to have_key(:id)
      expect(social[:type]).to eq("social") 
      expect(social[:attributes][:name]).to eq("Wine with Weenies") 
      expect(social[:attributes][:description]).to eq("Wine with Weenies is a social event for Weiner Dog owners to meet and mingle with other Weiner Dog owners.") 
      expect(social[:attributes][:location]).to eq("Denver, CO") 
      expect(social[:attributes][:event_date]).to eq("2024-01-10T00:00:00.000Z") 
      expect(social[:attributes][:event_type]).to eq("chill") 
    end
  end
end