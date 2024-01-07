require 'rails_helper'

RSpec.describe 'Users Edit' do 
  describe 'User Dashboard Updates' do 
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
      visit edit_user_path(2)

      fill_in :name, with: 'Mikey Boi'
      fill_in :email, with: 'mike@gmail.com'
      fill_in :password, with: 'password'
      fill_in :password_confirmation, with: 'password'
      click_button('Save')

      expect(current_path).to eq(user_path(2))

      expect(page).to have_content("Mikey Boi's Dashboard")
    end
  end 

  describe '#sad-path' do
    it 'passwords must match', :vcr do
      visit edit_user_path(4)

      fill_in :name, with: 'Boo'
      fill_in :email, with: 'boo@gmail.com'
      fill_in :password, with: 'password'
      fill_in :password_confirmation, with: 'ItsaMe'
      click_button('Save')

      expect(current_path).to eq(edit_user_path(4))

      expect(page).to have_content("Passwords Must Match")
    end

    it "Email can't be blank", :vcr do
      visit edit_user_path(4)

      fill_in :name, with: 'Boo'
      fill_in :email, with: ''
      fill_in :password, with: 'password'
      fill_in :password_confirmation, with: 'password'
      click_button('Save')

      expect(current_path).to eq(edit_user_path(4))

      expect(page).to have_content("Email can't be blank, Email is invalid")
    end

    it "must be an email", :vcr do
      visit edit_user_path(4)

      fill_in :name, with: 'Boo'
      fill_in :email, with: 'noatsigndotcom'
      fill_in :password, with: 'password'
      fill_in :password_confirmation, with: 'password'
      click_button('Save')

      expect(current_path).to eq(edit_user_path(4))

      expect(page).to have_content("Email is invalid")
    end

    it "Name can't be blank do", :vcr do
      visit edit_user_path(4)

      fill_in :name, with: ''
      fill_in :email, with: 'boo@gmail.com'
      fill_in :password, with: 'password'
      fill_in :password_confirmation, with: 'password'
      click_button('Save')

      expect(current_path).to eq(edit_user_path(4))

      expect(page).to have_content("Name can't be blank")
    end
  end
end 