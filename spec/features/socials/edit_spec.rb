require "rails_helper"

RSpec.describe "Socials Edit" do
  before :each do
    @user = UsersFacade.find_user(1)

    visit new_user_social_path(1)

    fill_in :name, with: "You"
    fill_in :description, with: "Crank that"
    select("Chill", from: :event_type)
    fill_in :locality, with: "Mountain View"
    fill_in :addressLines, with: "1600 Amphitheatre Parkway"
    fill_in('datetime', with: '2024-01-20T12:34')

    click_button "Create Social"

    @social = SocialsFacade.find_socials(1)
  
  end


  it 'when i visit the socials index there is a button to edit the social', :vcr do 
    visit user_socials_path(1)

    expect(page).to have_button("Edit Social")
    click_button("Edit Social")
    expect(current_path).to eq(edit_user_social_path(1, @social.id))
  end

  xit 'when i visit the socials show there is a button to edit the social' do 
    visit user_social_path(1, 1)

    expect(page).to have_button("Edit Social")
    click_button("Edit Social")
    expect(current_path).to eq(edit_user_social_path(1, @social.id))
  end

  xit 'when i visit the edit page i see Edit an Existing Social and text fields to change the socials
    details with the pre-existing social info filled in', :vcr do
    visit edit_user_social_path(1, 1)

    expect(page).to have_content("Edit an Existing Social")
    expect(page).to have_field :name, with: 'You'
    expect(page).to have_field :description, with: 'Crank that'
    expect(page).to have_select('event_type', selected: 'Chill')
    expect(page).to have_field :locality, with: 'Mountain View'
    expect(page).to have_field :addressLines, with: '1600 Amphitheatre Parkway'
    expect(page).to have_field :datetime, with: '2024-01-20T12:34'
    expect(page).to have_button("Update")
  end

  xit 'when i fill out the form with my changes and click update i am redirected to the 
  social show page where the updated info is displayed', :vcr do 
    visit edit_user_social_path(1, 1)

    fill_in :name, with 'Francisco'
    click_button("Update")

    expect(current_path).to eq(user_social_path(1, 1))
    expect(page).to have_field :name, with: 'Francisco'
    expect(page).to have_field :description, with: 'Crank that'
    expect(page).to have_select('event_type', selected: 'Chill')
    expect(page).to have_field :locality, with: 'Mountain View'
    expect(page).to have_field :addressLines, with: '1600 Amphitheatre Parkway'
    expect(page).to have_field :datetime, with: '2024-01-20T12:34'

    # reset 
    visit edit_user_social_path(1, 1)

    fill_in :name, with 'You'
    click_button("Update")
  end

  xit 'name field cant be left blank', :vcr do 
    visit edit_user_social_path(1, 1)

    fill_in :name, with: ''
    expect(page).to have_field :description, with: 'Crank that'
    expect(page).to have_select('event_type', selected: 'Chill')
    expect(page).to have_field :locality, with: 'Mountain View'
    expect(page).to have_field :addressLines, with: '1600 Amphitheatre Parkway'
    expect(page).to have_field :datetime, with: '2024-01-20T12:34'

    expect(current_path).to eq(edit_user_social_path(1, 1))
    expect(page).to have_content("**NO FIELDS CAN BE LEFT BLANK.**")
  end

  xit 'description field cant be left blank', :vcr do 
    visit edit_user_social_path(1, 1)

    expect(page).to have_field :name, with: 'You'
    fill_in :description, with: ''
    expect(page).to have_select('event_type', selected: 'Chill')
    expect(page).to have_field :locality, with: 'Mountain View'
    expect(page).to have_field :addressLines, with: '1600 Amphitheatre Parkway'
    expect(page).to have_field :datetime, with: '2024-01-20T12:34'

    expect(current_path).to eq(edit_user_social_path(1, 1))
    expect(page).to have_content("**NO FIELDS CAN BE LEFT BLANK.**")
  end

  xit 'locality field cant be left blank', :vcr do 
    visit edit_user_social_path(1, 1)

    expect(page).to have_field :name, with: 'You'
    expect(page).to have_field :description, with: 'Crank that'
    expect(page).to have_select('event_type', selected: 'Chill')
    fill_in :locality, with: ''
    expect(page).to have_field :addressLines, with: '1600 Amphitheatre Parkway'
    expect(page).to have_field :datetime, with: '2024-01-20T12:34'

    expect(current_path).to eq(edit_user_social_path(1, 1))
    expect(page).to have_content("**NO FIELDS CAN BE LEFT BLANK.**")
  end

  xit 'addressLines field cant be left blank', :vcr do 
    visit edit_user_social_path(1, 1)

    expect(page).to have_field :name, with: 'You'
    expect(page).to have_field :description, with: 'Crank that'
    expect(page).to have_select('event_type', selected: 'Chill')
    expect(page).to have_field :locality, with: 'Mountain View'
    fill_in :addressLines, with: ''
    expect(page).to have_field :datetime, with: '2024-01-20T12:34'

    expect(current_path).to eq(edit_user_social_path(1, 1))
    expect(page).to have_content("**NO FIELDS CAN BE LEFT BLANK.**")
  end

  xit 'datetime field cant be left blank', :vcr do 
    visit edit_user_social_path(1, 1)

    expect(page).to have_field :name, with: 'You'
    expect(page).to have_field :description, with: 'Crank that'
    expect(page).to have_select('event_type', selected: 'Chill')
    expect(page).to have_field :locality, with: 'Mountain View'
    expect(page).to have_field :addressLines, with: '1600 Amphitheatre Parkway'
    fill_in :datetime, with: ''

    expect(current_path).to eq(edit_user_social_path(1, 1))
    expect(page).to have_content("**NO FIELDS CAN BE LEFT BLANK.**")
  end
end