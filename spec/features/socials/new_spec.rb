require "rails_helper"

RSpec.describe 'Socials New' do
  before :each do
    
  end

  it 'exists', :vcr do
    visit user_path(3)
    # save_and_open_page
    expect(page).to have_button("Create a Social")
    click_button("Create a Social")

    expect(current_path).to eq( new_user_social_path(3))

    expect(page).to have_content("Create a Social")
    expect(page).to have_field(:name)
  end
end