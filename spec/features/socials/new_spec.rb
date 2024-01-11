require "rails_helper"

RSpec.describe 'Socials New' do
  before :each do
    visit root_path

    click_link "Login"

    fill_in :email, with: "boo@gmail.com"
    fill_in :name, with: "Boo"
    fill_in :password, with: "password"

    click_button "Login"
  end

  it 'exists', :vcr do
    visit user_path(3)

    expect(page).to have_button("Create a Social")
    click_button("Create a Social")

    expect(current_path).to eq(new_user_social_path(3))

    expect(page).to have_content("Create a Social")
    expect(page).to have_field(:name)
    expect(page).to have_field(:description)
    expect(page).to have_select(:event_type)
    expect(page).to have_field(:locality)
    expect(page).to have_field(:addressLines)
    expect(page).to have_field('datetime', type: 'datetime-local')
  end

  it 'I can fill in new fields and create a social', :vcr do
    visit new_user_social_path(3)

    fill_in :name, with: "You"
    fill_in :description, with: "Crank that"
    select("Chill", from: :event_type)
    fill_in :locality, with: "Mountain View"
    fill_in :addressLines, with: "1600 Amphitheatre Parkway"
    fill_in('datetime', with: '2024-01-20T12:34')

    click_button "Create Social"

    expect(current_path).to_not eq(new_user_social_path(3))
    expect(page).to have_content("Social Created")
  end

  it 'dynamic addresses create a successful map', :vcr do
    visit new_user_social_path(3)

    fill_in :name, with: "You"
    fill_in :description, with: "Crank that"
    select("Chill", from: :event_type)
    fill_in :locality, with: "Boone"
    fill_in :addressLines, with: "River Steet"
    fill_in('datetime', with: '2024-01-20T12:34')

    click_button "Create Social"

    expect(current_path).to_not eq(new_user_social_path(3))
    expect(page).to have_content("Social Created")
  end

  describe '#sad-path' do
    it "Address doesn't need to be specific", :vcr do
      # Not full city name
      # Baseball team name and the word stadium, expecting 'Smith's Ballpark'
      # This test is to see how loose one can be with putting in the address
          # Most people know the trailhead name, but not the trailhead parking address

      visit new_user_social_path(3)

      fill_in :name, with: "You"
      fill_in :description, with: "Crank that"
      select("Chill", from: :event_type)
      fill_in :locality, with: "Salt Lake"
      fill_in :addressLines, with: "Bee's Stadium"
      fill_in('datetime', with: '2024-01-20T12:34')

      click_button "Create Social"

      expect(current_path).to_not eq(new_user_social_path(3))
      expect(page).to have_content("Social Created")
    end
    describe '#filling out fields' do
      it 'Name', :vcr do
        visit new_user_social_path(3)

        fill_in :name, with: ""
        fill_in :description, with: "Crank that"
        select("Chill", from: :event_type)
        fill_in :locality, with: "Mountain View"
        fill_in :addressLines, with: "1600 Amphitheatre Parkway"
        fill_in('datetime', with: '2024-01-20T12:34')

        click_button "Create Social"

        expect(current_path).to eq(new_user_social_path(3))
        expect(page).to have_content("Name can't be blank")
      end

      it 'Description', :vcr do
        visit new_user_social_path(3)

        fill_in :name, with: "You"
        fill_in :description, with: ""
        select("Chill", from: :event_type)
        fill_in :locality, with: "Mountain View"
        fill_in :addressLines, with: "1600 Amphitheatre Parkway"
        fill_in('datetime', with: '2024-01-20T12:34')

        click_button "Create Social"

        expect(current_path).to eq(new_user_social_path(3))
        expect(page).to have_content("Description can't be blank")
      end

      it 'Event_Type', :vcr do
        visit new_user_social_path(3)

        fill_in :name, with: "You"
        fill_in :description, with: "Crank that"
        # select("", from: :event_type)
        fill_in :locality, with: "Mountain View"
        fill_in :addressLines, with: "1600 Amphitheatre Parkway"
        fill_in('datetime', with: '2024-01-20T12:34')

        click_button "Create Social"

        expect(current_path).to_not eq(new_user_social_path(3))
        expect(page).to have_content("Social Created")

        socials = SocialsFacade.find_socials(3)
        social = socials.last
        expect(social.event_type).to eq("chill")
      end

      it 'locality', :vcr do
        visit new_user_social_path(3)

        fill_in :name, with: "You"
        fill_in :description, with: "Crank that"
        select("Chill", from: :event_type)
        fill_in :locality, with: ""
        fill_in :addressLines, with: "1470 400 W"
        fill_in('datetime', with: '2024-01-20T12:34')

        click_button "Create Social"

        expect(current_path).to eq(new_user_social_path(3))
        expect(page).to have_content("City and address must be filled in")
      end

      it 'addressLines', :vcr do
        visit new_user_social_path(3)

        fill_in :name, with: "You"
        fill_in :description, with: "Crank that"
        select("Chill", from: :event_type)
        fill_in :locality, with: "Mountain View"
        fill_in :addressLines, with: ""
        fill_in('datetime', with: '2024-01-20T12:34')

        click_button "Create Social"

        expect(current_path).to eq(new_user_social_path(3))
        expect(page).to have_content("Address lines missing from request")
      end

      it 'datetime', :vcr do
        visit new_user_social_path(3)

        fill_in :name, with: "You"
        fill_in :description, with: "Crank that"
        select("Chill", from: :event_type)
        fill_in :locality, with: "Mountain View"
        fill_in :addressLines, with: "1600 Apmhitheatre PArkway"
        # fill_in('datetime', with: '2024-01-20T12:34')

        click_button "Create Social"

        expect(current_path).to eq(new_user_social_path(3))
        expect(page).to have_content("Event date can't be blank")
      end
    end
  end
end