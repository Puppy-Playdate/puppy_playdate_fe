require 'rails_helper'

RSpec.describe 'Users Show' do 
  describe 'User Dashboard' do 
    it 'exists', :vcr do 
      visit '/users/1' 

      expect(page).to have_content("James Sullivan's Dashboard")
      expect(page).to have_link('Edit Profile')
      expect(page).to have_button('Log Out')
      expect(page).to have_button('Add Pet')
      expect(page).to have_button('View Pets')
      expect(page).to have_button('Discover Socials')

      # This user story looks to have all of a users pets shown- 
      # waiting on pets added to db
    end
  end
end