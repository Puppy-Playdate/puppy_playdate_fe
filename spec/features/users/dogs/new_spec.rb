require "rails_helper"

RSpec.describe "User Dog Index" do
  before(:each) do
    @user = UsersFacade.find_user(1)
  end

  it 'the user dashboard has an add dog button and it takes you to the add dog path', :vcr do
    visit user_path(1)

    expect(page).to have_content("Add New Dog")
    click_button("Add New Dog")
    expect(current_path).to eq(add_dog_path(1))
  end

  xit 'has a form to fill in', :vcr do
    visit add_dog_path(1)

    expect(page).to have_field("Name:")
    expect(page).to have_field("Breed:")
    expect(page).to have_field("Age:")
    expect(page).to have_field("Size:") # edit this to a drop down sm, med, lg selector
    expect(page).to have_field("Neutered:") # selector for t/f
    expect(page).to have_button("Create Dog")

    fill_in :name, with: "Akila"
    fill_in :breed, with: "Great Pyrenees"
    fill_in :age, with: 8
    fill_in :size, with: "large" # change this to fill in options for selector
    fill_in :neutered, with: "true" # change this to fill in options for selector

    click_button("Create Dog")
    expect(current_path).to eq(user_path(1))
    expect(page).to have_content("Akila")
    expect(page).to have_content("Great Pyrenees")
    expect(page).to have_content(8)
    expect(page).to have_content("large")
    expect(page).to have_content("true")
  end

  describe "#sad-path, dog can not be created if all fields are not filled in" do
    xit 'dog can not be created without name filled in', :vcr do 
      visit add_dog_path(1)

      fill_in :breed, with: "Great Pyrenees"
      fill_in :age, with: 8
      fill_in :size, with: "large" # change this to fill in options for selector
      fill_in :neutered, with: "true" # change this to fill in options for selector
      click_button("Create Dog")
      expect(current_path).to eq(add_dog_path(1))
      expect(page).to have_content("Please make sure all fields are filled in.")
    end

    xit 'dog can not be created without breed filled in', :vcr do 
      visit add_dog_path(1)

      fill_in :name, with: "Akila"
    
      fill_in :age, with: 8
      fill_in :size, with: "large" # change this to fill in options for selector
      fill_in :neutered, with: "true" # change this to fill in options for selector
      click_button("Create Dog")
      expect(current_path).to eq(add_dog_path(1))
      expect(page).to have_content("Please make sure all fields are filled in.")
    end

    xit 'dog can not be created without age filled in', :vcr do 
      visit add_dog_path(1)

      fill_in :name, with: "Akila"
      fill_in :breed, with: "Great Pyrenees"
      
      fill_in :size, with: "large" # change this to fill in options for selector
      fill_in :neutered, with: "true" # change this to fill in options for selector
      click_button("Create Dog")
      expect(current_path).to eq(add_dog_path(1))
      expect(page).to have_content("Please make sure all fields are filled in.")
    end

    xit 'dog can not be created without size filled in', :vcr do 
      visit add_dog_path(1)

      fill_in :name, with: "Akila"
      fill_in :breed, with: "Great Pyrenees"
      fill_in :age, with: 8
      
      fill_in :neutered, with: "true" # change this to fill in options for selector
      click_button("Create Dog")
      expect(current_path).to eq(add_dog_path(1))
      expect(page).to have_content("Please make sure all fields are filled in.")
    end

    xit 'dog can not be created without neutered filled in', :vcr do 
      visit add_dog_path(1)

      fill_in :name, with: "Akila"
      fill_in :breed, with: "Great Pyrenees"
      fill_in :age, with: 8
      fill_in :size, with: "large" # change this to fill in options for selector
      
      click_button("Create Dog")
      expect(current_path).to eq(add_dog_path(1))
      expect(page).to have_content("Please make sure all fields are filled in.")
    end
  end


end