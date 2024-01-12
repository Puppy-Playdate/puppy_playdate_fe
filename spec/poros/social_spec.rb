require 'rails_helper'

RSpec.describe Social do 
  describe 'initialize' do 
    it 'exists with attributes' do 
      social_data = {
        id: "135",
        type: "social",
        attributes: {
          name: "Mutts on Main St.",
          description: "Main St. takeover",
          location: "Houston, TX",
          event_date: Date.today,
          event_type: "walk"
        }
      }

      social = Social.new(social_data)

      expect(social).to be_a Social
      expect(social.id).to eq(135)
      expect(social.name).to eq("Mutts on Main St.")
      expect(social.description).to eq("Main St. takeover")
      expect(social.location).to eq("Houston, TX")
      expect(social.event_date).to eq(Date.today)
    end 
  end 
end 