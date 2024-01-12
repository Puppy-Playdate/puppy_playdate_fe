require 'rails_helper'

RSpec.describe 'Users Show' do 
  describe 'User Dashboard' do 
    before :each do 
      visit '/users/1'
    end

    it 'exists', :vcr do 
      
      expect(page).to have_button('Edit Profile')
      expect(page).to have_button('Add New Dog')
      expect(page).to have_button('View Pets')
      expect(page).to have_button('Discover Socials')

      # This user story looks to have all of a users pets shown- 
      # waiting on pets added to db
    end

    it 'routes a user to an edit user page', :vcr do
      click_button "Edit Profile"
      expect(current_path).to eq(edit_user_path(1)) 
    end 

    it 'routes a user to a form page to add a pet to a users profile', :vcr do
      click_button "Add New Dog"
      expect(current_path).to eq(new_user_dog_path(1)) 
    end 

    it 'routes a user to their users dogs page', :vcr do
      click_button "View Pets"
      expect(current_path).to eq(user_dogs_path(1)) 
    end 

    it 'routes a user to the socials page', :vcr do
      visit root_path

      click_link "Login"

      fill_in :email, with: "boo@gmail.com"
      fill_in :name, with: "Boo"
      fill_in :password, with: "password"

      click_button "Login"
      
      visit user_path(4)

      click_button "Discover Socials"
      expect(current_path).to eq(user_socials_path(4)) 
    end 
  end
end