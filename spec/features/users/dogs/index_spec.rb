require "rails_helper"

RSpec.describe "User Dog Index" do
  before(:each) do
    @user = UsersFacade.find_user(1)
  end

  it 'displays dogs with their name, breed, size, fixed status and photo of dog', :vcr do
    visit dogs_path(@user)

    expect(page).to have_content("#{@user.name}'s Dogs")
    expect(page).to have_content("Name:")
    expect(page).to have_content("Breed:")
    expect(page).to have_content("Age:")
    expect(page).to have_content("Size:")
    expect(page).to have_content("Neutered:")
    # research how to test for dog photo
  end

  xit 'has a button to edit dog and said button redirects to dog edit path' do
    visit '/users/:id/dogs'
    expect(page).to have_button("Edit Dog")
    click_button "Edit Dog"
    expect(current_path).to eq('/users/:id/dogs/:dog_id/edit')
  end
  
  xit 'has a button to add dog and said button redirects to dog new path' do
    visit '/users/:id/dogs'
    expect(page).to have_button("Add Dog")
    click_button "Add Dog"
    expect(current_path).to eq('/users/:id/dogs/new')
  end
end