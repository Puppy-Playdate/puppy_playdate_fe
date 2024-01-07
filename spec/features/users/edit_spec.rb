require 'rails_helper'

RSpec.describe 'Users Edit' do 
  describe 'User Dashboard' do 
    it 'exists', :vcr do 
      visit edit_user_path(1)

      expect(page).to have_content("Editing James Sullivan's Profile")
      expect(page).to have_field :name, with: 'James Sullivan'
      expect(page).to have_field :email, with: 'sully@gmail.com'
      expect(page).to have_field :password 
      expect(page).to have_field :password_confirmation  
      expect(page).to have_button('Save')  
      expect(page).to have_link('Back to User Dashboard')  

      # No use of updating a profile photo as I thought we were still deciding on whether or not to use images 
    end 

    it 'routes a user back to their dashboard page updated information', :vcr do 
      visit edit_user_path(1)

      fill_in :name, with: 'James Sullivan Sr.'
      fill_in :email, with: 'sully@gmail.com'
      fill_in :password, with: 'password'
      fill_in :password_confirmation, with: 'password'
      click_button('Save')

      expect(current_path).to eq(user_path(1))

      expect(page).to have_content("James Sullivan Sr.'s Dashboard")
    end
  end 
end 