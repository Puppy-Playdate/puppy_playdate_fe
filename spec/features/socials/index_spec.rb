require "rails_helper"

RSpec.describe "Socials Index" do
  before :each do
    visit root_path
  
      click_link "Login"
  
      fill_in :email, with: "boo@gmail.com"
      fill_in :name, with: "Boo"
      fill_in :password, with: "password"
  
      click_button "Login"
  end
  it "will show all socials" do
    visit user_socials_path(4)

    expect(page).to have_content("All Socials")
  end
end