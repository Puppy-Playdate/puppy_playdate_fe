require "rails_helper"

RSpec.describe "Socials Edit" do
  before :each do
    visit root_path

    click_link "Login"
    fill_in :email, with: "boo@gmail.com"
    fill_in :name, with: "Boo"
    fill_in :password, with: "password"
    click_button "Login"

    visit new_user_social_path(4)

    fill_in :name, with: "Soulja Boy"
    fill_in :description, with: "Crank that"
    select("Chill", from: :event_type)
    fill_in :locality, with: "Mountain View"
    fill_in :addressLines, with: "1600 Amphitheatre Parkway"
    fill_in('datetime', with: '2024-01-20T12:34')

    click_button "Create Social"

    socials = SocialsFacade.find_socials(4)
    @social = socials.last
  end


  it 'when i visit the socials index there is a button to edit the social', :vcr do 
    visit user_socials_path(4)
    # write within block to test for specific socials edit button
    within(".social-box", text: @social.name) do
      expect(page).to have_button("Edit Social")
      click_button("Edit Social")
    end
    expect(current_path).to eq(edit_user_social_path(4, @social.id))
  end

  it 'when i visit the socials show there is a button to edit the social', :vcr do 
    visit user_social_path(4, @social.id)

    expect(page).to have_button("Edit Social")
    click_button("Edit Social")
    expect(current_path).to eq(edit_user_social_path(4, @social.id))
  end

  xit 'when i visit the edit page i see Edit an Existing Social and text fields to change the socials
    details with the pre-existing social info filled in', :vcr do
    visit edit_user_social_path(4, @social.id)

    expect(page).to have_content("Edit an Existing Social")
    expect(page).to have_field :name, with: 'Soulja Boy'
    expect(page).to have_field :description, with: 'Crank that'
    expect(page).to have_select(:event_type, with_options: ['Chill'], selected: 'Chill')
    expect(page).to have_field :addressLines, with: '1600 Amphitheatre Parkway, Mountain View, CA 94043-1351, USA'
    expect(page).to have_field :datetime, with: '2024-01-20T12:34:00.000Z'
    expect(page).to have_button("Update")
  end

  xit 'when i fill out the form with my changes and click update i am redirected to the 
    social show page where the updated info is displayed', :vcr do 
    visit edit_user_social_path(4, @social.id)

    fill_in :name, with: 'Francisco'
    click_button("Update")

    expect(current_path).to eq(user_social_path(4, @social.id))
    expect(page).to have_field :name, with: 'Francisco'
    expect(page).to have_field :description, with: 'Crank that'
    expect(page).to have_select(:event_type, selected: 'Chill')
    expect(page).to have_field :addressLines, with: '1600 Amphitheatre Parkway, Mountain View, CA 94043-1351, USA'
    expect(page).to have_field :datetime, with: '2024-01-20T12:34:00.000Z'

    # reset 
    visit edit_user_social_path(4, @social.id)

    fill_in :name, with: 'Soulja Boy'
    click_button("Update")
  end

  xit 'name field cant be left blank', :vcr do 
    visit edit_user_social_path(4, @social.id)

    fill_in :name, with: ''
    expect(page).to have_field :description, with: 'Crank that'
    expect(page).to have_content("Chill")
    expect(page).to have_field :locality, with: '1600 Amphitheatre Parkway, Mountain View, CA 94043-1351, USA'
    expect(page).to have_field :datetime, with: '2024-01-20T12:34:00.000Z'

    expect(current_path).to eq(edit_user_social_path(4, @social.id))
    expect(page).to have_content("**NO FIELDS CAN BE LEFT BLANK.**")
  end

  xit 'description field cant be left blank', :vcr do 
    visit edit_user_social_path(4, @social.id)

    expect(page).to have_field :name, with: 'Soulja Boy'
    fill_in :description, with: ''
    expect(page).to have_content("Chill")
    expect(page).to have_field :locality, with: '1600 Amphitheatre Parkway, Mountain View, CA 94043-1351, USA'
    expect(page).to have_field :datetime, with: '2024-01-20T12:34:00.000Z'

    expect(current_path).to eq(edit_user_social_path(4, @social.id))
    expect(page).to have_content("**NO FIELDS CAN BE LEFT BLANK.**")
  end

  xit 'locality field cant be left blank', :vcr do 
    visit edit_user_social_path(4, @social.id)

    expect(page).to have_field :name, with: 'Soulja Boy'
    expect(page).to have_field :description, with: 'Crank that'
    expect(page).to have_content("Chill")
    fill_in :locality, with: ''
    expect(page).to have_field :datetime, with: '2024-01-20T12:34:00.000Z'

    expect(current_path).to eq(edit_user_social_path(4, @social.id))
    expect(page).to have_content("**NO FIELDS CAN BE LEFT BLANK.**")
  end

  xit 'datetime field cant be left blank', :vcr do 
    visit edit_user_social_path(4, @social.id)

    expect(page).to have_field :name, with: 'Soulja Boy'
    expect(page).to have_field :description, with: 'Crank that'
    expect(page).to have_content("Chill")
    expect(page).to have_field :locality, with: '1600 Amphitheatre Parkway, Mountain View, CA 94043-1351, USA'
    fill_in :datetime, with: ''

    expect(current_path).to eq(edit_user_social_path(4, @social.id))
    expect(page).to have_content("**NO FIELDS CAN BE LEFT BLANK.**")
  end
end