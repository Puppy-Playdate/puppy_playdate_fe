require 'rails_helper'

RSpec.describe 'Users Show' do 
  describe 'User Dashboard' do 
    before :each do 
      visit '/users/1' 
    end

    it 'exists', :vcr do 
      expect(page).to have_content("James Sullivan's Dashboard")
      expect(page).to have_link('Edit Profile')
      expect(page).to have_button('Log Out')
      expect(page).to have_button('Add Pet')
      expect(page).to have_button('View Pets')
      expect(page).to have_button('Discover Socials')

      # This user story looks to have all of a users pets shown- 
      # waiting on pets added to db
    end

    it 'routes a user to an edit user page', :vcr do
      click_link "Edit Profile"
      expect(current_path).to eq(edit_path) 
    end 

    xit 'logs a user out and returns back to the landing page', :vcr do
      click_button "Log Out"
      expect(current_path).to eq(root_path) 
    end 

    xit 'routes a user to a form page to add a pet to a users profile', :vcr do
      click_link "Add Pet"
      expect(current_path).to eq() 
    end 

    xit 'routes a user to an edit user page', :vcr do
      click_link "View Pets"
      expect(current_path).to eq() 
    end 

    xit 'routes a user to an edit user page', :vcr do
      click_link "Discover Socials"
      expect(current_path).to eq() 
    end 
  end
end