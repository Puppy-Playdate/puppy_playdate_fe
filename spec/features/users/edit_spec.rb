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
      expect(page).to have_button('Save')  
      expect(page).to have_link('Back to User Dashboard')  

      # No use of updating a profile photo as I thought we were still deciding on whether or not to use images 
    end 
  end 
end 