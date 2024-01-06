require "rails_helper"

RSpec.describe "User Dog Index" do
  before(:each) do
    visit new_user_path

    fill_in :name, with: "Eric"
    fill_in :email, with: "superuniqueemail@wahoo.com"
    fill_in :password, with: "SuperSecret"
    fill_in :password_confirmation, with: "SuperSecret"
    click_button("Create New User")
  end

  xit 'displays dogs with their name, breed, size, fixed status and photo of dog', :vcr do
    visit dogs_path
    expect(page).to have_content("#{@user.name}'s Dogs")
    expect(page).to have_content("Name:")
    expect(page).to have_content("Breed:")
    expect(page).to have_content("Age:")
    expect(page).to have_content("Size:")
    expect(page).to have_content("Fixed:")
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