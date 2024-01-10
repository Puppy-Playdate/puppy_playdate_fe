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
    # save_and_open_page
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
    # require 'pry'; binding.pry
    expect(current_path).to_not eq(new_user_social_path(3))
    expect(page).to have_content("Social Created")
  end
end