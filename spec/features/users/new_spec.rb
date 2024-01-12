require "rails_helper"

RSpec.describe "User Creation" do
  it "Has a form to fill in", :vcr do
    visit new_user_path
    expect(page).to have_content("Create an Account")
    expect(page).to have_button("Create New User")

    fill_in :name, with: "Eric"
    fill_in :email, with: "slim@shady.com"
    fill_in :password, with: "SuperSecret"
    fill_in :password_confirmation, with: "SuperSecret"
    click_button("Create New User")

    expect(page).to have_content("Account Created")
    expect(page).to have_content("Eric")
    expect(page).to have_content("slim@shady.com")
  end

  describe '#sad-path' do
    it 'passwords must match', :vcr do
      visit new_user_path

      fill_in :name, with: "Eric"
      fill_in :email, with: "superuniqueemail@wahoo.com"
      fill_in :password, with: "SuperSecret"
      fill_in :password_confirmation, with: "NotIt!"
      click_button("Create New User")

      expect(current_path).to eq(new_user_path)

      expect(page).to have_content("Passwords Must Match")
    end

    it "Must have a unqiue email", :vcr do
      visit new_user_path

      fill_in :name, with: "Eric"
      fill_in :email, with: "superuniqueemail@wahoo.com"
      fill_in :password, with: "SuperSecret"
      fill_in :password_confirmation, with: "SuperSecret"
      click_button("Create New User")

      
      visit new_user_path

      fill_in :name, with: "Eric"
      fill_in :email, with: "superuniqueemail@wahoo.com"
      fill_in :password, with: "SuperSecret"
      fill_in :password_confirmation, with: "SuperSecret"
      click_button("Create New User")
      
      expect(current_path).to eq(new_user_path)

      expect(page).to have_content("Email has already been taken")
    end
    
  end
end