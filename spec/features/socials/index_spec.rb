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
  it "will show all socials", :vcr do
    visit user_socials_path(4)

    socials = SocialsFacade.find_socials(4)

    expect(page).to have_content("All Socials")

    within(".social-container") do
      socials.each do |social|
        expect(page).to have_content(social.name)
        expect(page).to have_content(social.event_type)
        expect(page).to have_content(social.event_date)
        # expect(page).to have_content(social.location)
      end
    end
  end
end