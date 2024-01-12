require "rails_helper"

RSpec.describe "User Login" do
  it "login page exists" do
    visit root_path

    expect(page).to have_link("Login")
    click_link("Login")
    expect(current_path).to eq(login_path)
  end

  it "Can login an existing user", :vcr do
    visit login_path
    save_and_open_page
    expect(page).to have_content("Existing Member Login")
    expect(page).to have_button("Login")
    expect(page).to have_button("Login with Google")
    # expect(page).to have_button("Login with GitHub")
    within("div#navigation_station") do
      expect(page).to have_link("Home")
      expect(page).to have_link("Create New User")
      expect(page).to have_link("Login")
      expect(page).to_not have_link("Log out")
      expect(page).to_not have_link("My Dashboard")
    end


    fill_in :email, with: "boo@gmail.com"
    fill_in :name, with: "Boo"
    fill_in :password, with: "password"
    click_button("Login")

    within("div#navigation_station") do
      expect(page).to have_link("Home")
      expect(page).to_not have_link("Create New User")
      expect(page).to_not have_link("Login")
      expect(page).to have_link("Log out")
      expect(page).to have_link("My Dashboard")
    end
    # save_and_open_page
    expect(current_path).to eq(user_path(4))
  end

  describe '#sad-path' do
    it 'Wrong Password', :vcr do
      visit login_path
      
      fill_in :email, with: "boo@gmail.com"
      fill_in :name, with: "Boo"
      fill_in :password, with: "123"
      click_button("Login")

      expect(current_path).to eq(login_path)
      expect(page).to have_content("Sorry, your credentials are bad")
    end

    it "Not an account at all", :vcr do
      visit login_path

      fill_in :email, with: "nope@gmail.com"
      fill_in :name, with: "Big Nope"
      fill_in :password, with: "123"
      click_button("Login")

      expect(current_path).to eq(login_path)
      expect(page).to have_content("This email is not associated with an account")
    end
  end
end