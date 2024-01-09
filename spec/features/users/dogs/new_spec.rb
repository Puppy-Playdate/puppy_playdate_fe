require "rails_helper"

RSpec.describe "User Dog Index" do
  before(:each) do
    @user = UsersFacade.find_user(1)
  end

  it 'the user dashboard has an add dog button and it takes you to the add dog path', :vcr do
    visit user_path(1)

    expect(page).to have_content("Add New Dog")
    click_button("Add New Dog")
    expect(current_path).to eq(new_user_dog_path(1))
  end

  it 'has a form to fill in', :vcr do
    visit new_user_dog_path(1)
    
    expect(page).to have_field("Name")
    expect(page).to have_field("Breed")
    expect(page).to have_field("Age")
    expect(page).to have_select("Size") 
    expect(page).to have_select("Neutered")
    expect(page).to have_button("Create Dog")

    fill_in :name, with: "Akila"
    fill_in :breed, with: "Great Pyrenees"
    fill_in :age, with: "8"
    select "large", from: "Size"
    select "true", from: "Neutered"
    click_button("Create Dog")
    
    expect(current_path).to eq(user_dogs_path(1))
    expect(page).to have_content("Akila")
    expect(page).to have_content("Great Pyrenees")
    expect(page).to have_content(8)
    expect(page).to have_content("large")
    expect(page).to have_content("true")
  end

  describe "#sad-path, dog can not be created if all fields are not filled in" do
    it 'dog can not be created without name filled in', :vcr do 
      visit new_user_dog_path(1)

      fill_in :breed, with: "Great Pyrenees"
      fill_in :age, with: 8
      select "large", from: "Size"
      select "true", from: "Neutered"
      click_button("Create Dog")
      
      expect(current_path).to eq(new_user_dog_path(1))
      expect(page).to have_content("Please make sure all fields are filled in.")
    end

    it 'dog can not be created without breed filled in', :vcr do 
      visit new_user_dog_path(1)

      fill_in :name, with: "Akila"
    
      fill_in :age, with: 8
      select "large", from: "Size"
      select "true", from: "Neutered"
      click_button("Create Dog")

      expect(current_path).to eq(new_user_dog_path(1))
      expect(page).to have_content("Please make sure all fields are filled in.")
    end

    it 'dog can not be created without age filled in', :vcr do 
      visit new_user_dog_path(1)

      fill_in :name, with: "Akila"
      fill_in :breed, with: "Great Pyrenees"
      
      select "large", from: "Size"
      select "true", from: "Neutered"
      click_button("Create Dog")

      expect(current_path).to eq(new_user_dog_path(1))
      expect(page).to have_content("Please make sure all fields are filled in.")
    end

    it 'dog can not be created without size filled in', :vcr do 
      visit new_user_dog_path(1)

      fill_in :name, with: "Akila"
      fill_in :breed, with: "Great Pyrenees"
      fill_in :age, with: 8
      
      select "true", from: "Neutered"
      click_button("Create Dog")

      expect(current_path).to eq(new_user_dog_path(1))
      expect(page).to have_content("Please make sure all fields are filled in.")
    end

    it 'dog can not be created without neutered filled in', :vcr do 
      visit new_user_dog_path(1)

      fill_in :name, with: "Akila"
      fill_in :breed, with: "Great Pyrenees"
      fill_in :age, with: 8
      select "large", from: "Size"
      
      click_button("Create Dog")

      expect(current_path).to eq(new_user_dog_path(1))
      expect(page).to have_content("Please make sure all fields are filled in.")
    end
  end
end