require 'rails_helper'

RSpec.describe 'Users Show' do 
  describe 'User Dashboard' do 
    before :each do 
      visit edit_path(1) 
    end

    it 'exists', :vcr do 
      expect(page).to have_content("Editing James Sullivan's Profile")
      expect(page).to have_field :first_name
      expect(page).to have_field :last_name
      expect(page).to have_field :email
      expect(page).to have_field :password 
    end 
  end 
end 