require "rails_helper"

RSpec.describe "Socials Show" do
  before :each do
    visit root_path

    click_link "Login"

    fill_in :email, with: "boo@gmail.com"
    fill_in :name, with: "Boo"
    fill_in :password, with: "password"

    click_button "Login"

    visit new_user_social_path(3)

    fill_in :name, with: "You"
    fill_in :description, with: "Crank that"
    select("Chill", from: :event_type)
    fill_in :locality, with: "Mountain View"
    fill_in :addressLines, with: "1600 Amphitheatre Parkway"
    fill_in('datetime', with: '2024-01-20T12:34')

    click_button "Create Social"
  end
  describe '#happy-path' do
    it 'exists', :vcr do
      socials = SocialsFacade.find_socials(4)
      social = socials.last
      host = UsersFacade.find_user(4)

      expect(current_path).to eq(user_social_path(4, social.id))

      expect(page).to have_content("#{social.name}")
      expect(page).to have_content("#{social.description}")
      expect(page).to have_content("#{social.event_type}")
      expect(page).to have_content("Host User: #{host.name}")

      # This is checking that the map is there
      # If you know of better ways to test please lmk -eb
      expect(find('#google_map')).to have_content('Find on Maps')
      expect(find('#google_map')).to have_selector('iframe')
    end
  end
end