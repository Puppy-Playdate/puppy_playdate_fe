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

    expect(page).to have_content("Existing Member Login")
    expect(page).to have_button("Login")
    expect(page).to have_button("Login with Google")
    # expect(page).to have_button("Login with GitHub")

    fill_in :email, with: "boo@gmail.com"
    fill_in :name, with: "Boo"
    fill_in :password, with: "password"
    click_button("Login")
    # save_and_open_page
    expect(current_path).to eq(user_path(4))
  end
end