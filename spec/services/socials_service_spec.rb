require 'rails_helper'

RSpec.describe SocialsService do
  describe 'class methods' do
    it '#create_social creates a new social', :vcr do
      user = UsersFacade.find_user(7)
      social_params = {
        name: 'Brunch with Boxers',
        description: 'Breakfast with Boxers is a social event for owners to meet and mingle on a walk to brunch.',
        location: 'Evansville, IN',
        event_date: Date.today,
        event_type: 'walk',
        user_id: user.user_id
      }    
      response = SocialsService.create_social(social_params)
      expect(response.status).to eq(201)

      social = JSON.parse(response.body, symbolize_names: true)
      expect(social).to be_a Hash

      boxer = social[:data]
      expect(boxer).to have_key :id
      expect(boxer).to have_key :type
      expect(boxer[:type]).to eq("social")
      expect(boxer).to have_key :attributes

      boxer_social = boxer[:attributes]
      expect(boxer_social[:name]).to eq('Brunch with Boxers')
      expect(boxer_social[:description]).to eq('Breakfast with Boxers is a social event for owners to meet and mingle on a walk to brunch.')
      expect(boxer_social[:location]).to eq('Evansville, IN')
      expect(boxer_social[:event_type]).to eq('walk')
    end 

    it '#find_social finds a single social associated to a user', :vcr do
      social = SocialsService.find_social(7, 1)
      weenie = social[:data][:attributes]
      
      expect(social).to be_a Hash
      expect(weenie[:name]).to eq("Wine with Weenies")
      expect(weenie[:description]).to eq("Wine with Weenies is a social event for Weiner Dog owners to meet and mingle with other Weiner Dog owners.")
      expect(weenie[:location]).to eq("Denver, CO")
      expect(weenie[:event_type]).to eq("chill")
    end

    it '#find_socials finds all socials for a given user id', :vcr do
      socials = SocialsService.find_socials(7)

      expect(socials[:data].count).to eq(6)
      boxer = socials[:data].last[:attributes]
      expect(boxer[:name]).to eq("Brunch with Boxers")
    end
  end 
end