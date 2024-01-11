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

      social = SocialsFacade.find_social(user.user_id, weenies[:social_id])
      
      expect(social).to be_a Social
      expect(social.name).to eq("Wine with Weenies") 
      expect(social.description).to eq("Wine with Weenies is a social event for Weiner Dog owners to meet and mingle with other Weiner Dog owners.") 
      expect(social.location).to eq("Denver, CO") 
      expect(social.event_type).to eq("chill") 
    end
  end
  
  describe '#find_social(user_id, social_id)' do
    it 'finds a social by a user & social id', :vcr do 
      user = UsersFacade.find_user(3)
      social_params = ({
        name: 'Wine with Weenies',
        description: 'Wine with Weenies is a social event for Weiner Dog owners to meet and mingle with other Weiner Dog owners.',
        location: 'Denver, CO',
        event_date: Date.today,
        event_type: 'chill',
        user_id: user.user_id
      })
      social = SocialsFacade.create_social(social_params)
      id = social[:social_id]
      weenies = SocialsFacade.find_social(user.user_id, id)

      expect(weenies).to be_a Social
      expect(weenies.description).to eq("Wine with Weenies is a social event for Weiner Dog owners to meet and mingle with other Weiner Dog owners.") 
      expect(weenies.event_type).to eq("chill") 
      expect(weenies.location).to eq("Denver, CO") 
      expect(weenies.name).to eq("Wine with Weenies") 
    end 
  end 

  describe '#find_socials(user_id)' do
    it 'finds all socials by a users id', :vcr do 
      user = UsersFacade.find_user(3)

      pit_params = ({
        name: 'Party With Pitties',
        description: 'Playtime with pitbulls.',
        location: 'Denver, CO',
        event_date: Date.today,
        event_type: 'chill',
        user_id: user.user_id
      })

      corgie_params = ({
        name: 'Cookies & Corgies',
        description: "Outdoor party for Kevy Spaghetti's birthday.",
        location: 'Denver, CO',
        event_date: Date.today,
        event_type: 'chill',
        user_id: user.user_id
      })

      pitties = SocialsFacade.create_social(pit_params)
      corgies = SocialsFacade.create_social(corgie_params)
      socials = SocialsFacade.find_socials(user.user_id)
      kevy = socials.last 

      expect(socials).to be_an Array 
      expect(kevy).to be_a Social
      expect(kevy).to be_a Social
      expect(kevy.description).to eq("Outdoor party for Kevy Spaghetti's birthday.") 
      expect(kevy.event_type).to eq("chill") 
      expect(kevy.location).to eq("Denver, CO") 
      expect(kevy.name).to eq("Cookies & Corgies") 
    end 
  end 
end