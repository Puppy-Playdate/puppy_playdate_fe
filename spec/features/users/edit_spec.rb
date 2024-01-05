require 'rails_helper'

RSpec.describe 'Users Show' do 
  describe 'User Dashboard' do 
    before :each do 
      visit edit_path(1) 
    end

    it 'exists', :vcr do 
      expect(page).to have_content("Editing James Sullivan's Profile")
      expect(page).to have_field :first_name, with: 'James'
      expect(page).to have_field :last_name, with: 'Sullivan'
      expect(page).to have_field :email, with: 'sully@gmail.com'
      expect(page).to have_field :password 
      expect(page).to have_field :password_confirmation  
      expect(page).to have_button('Save')  
      expect(page).to have_link('Back to User Dashboard')  

      # No use of updating a profile photo as I thought we were still deciding on whether or not to use images 
    end 

    it 'routes a user back to their dashboard page updated information', :vcr do 
      fill_in :last_name, with: 'Sullivan Sr.'
      fill_in :password, with: 'booWHO?'
      fill_in :password_confirmation, with: 'booWHO?'
      click_button('Save')

      expect(current_path).to eq(user_path(1))

      expect(page).to have_content("James Sullivan Sr.'s Dashboard")
    end
  end 
end 