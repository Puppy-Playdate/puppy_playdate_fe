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

      weenies = SocialsFacade.create_social(social_params)
      expect(weenies[:status]).to eq(201)

      social = SocialsFacade.find_social(user.user_id, weenies)
      
      expect(social).to be_a Social
      expect(social.name).to eq("Wine with Weenies") 
      expect(social.description).to eq("Wine with Weenies is a social event for Weiner Dog owners to meet and mingle with other Weiner Dog owners.") 
      expect(social.location).to eq("Denver, CO") 
      expect(social.event_type).to eq("chill") 
    end
  end
end