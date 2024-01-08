require "rails_helper"

RSpec.describe "User Dog Index" do
  before(:each) do
    @user = UsersFacade.find_user(1)
  end

  it 'displays dogs with their name, breed, size, fixed status', :vcr do
    visit dogs_path(1)
    expect(page).to have_content("#{@user.name}'s Dogs")
    expect(page).to have_content("Name: Fido")
    expect(page).to have_content("Breed: Lab")
    expect(page).to have_content("Age: 5")
    expect(page).to have_content("Size: medium")
    expect(page).to have_content("Neutered: true")
    expect(page).to have_content("Name: Bob")
    expect(page).to have_content("Breed: Pug")
    expect(page).to have_content("Age: 3")
    expect(page).to have_content("Size: small")
    expect(page).to have_content("Neutered: false")
    # add testing for dog photos if we decide to 
  end

  it 'has a button to edit dog and said button redirects to dog edit path', :vcr do
    visit dogs_path(1)
    within(".dog-container .dog-box", match: :first) do
      expect(page).to have_button("Edit Fido")
      click_button "Edit Fido"
      expect(current_path).to eq(edit_dog_path(1, 1))
    end
  end
  
  it 'has a button to add dog and said button redirects to dog new path', :vcr do
    visit dogs_path(1)
    expect(page).to have_button("Add New Dog")
    click_button "Add New Dog"
    expect(current_path).to eq(add_dog_path(1))
  end
end