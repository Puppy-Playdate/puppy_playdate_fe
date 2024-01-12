require "rails_helper"

RSpec.describe "User Dog Edit Page" do
  # before(:each) do
  #   @user = UsersFacade.find_user(1)
  # end

  # dog index edit button is tested in dog index spec
  # write a test with within blocks that each dog has an edit button

  it 'there is a form to fill out with my dogs previous info 
    prefilled for editing for each dog', :vcr do 
    visit edit_user_dog_path(1, 1)
    dog1 = DogsFacade.find_dog_by_id(1,1)

    expect(page).to have_content('Editing Fido')
    expect(page).to have_field :name, with: dog1.name
    expect(page).to have_field :breed, with: dog1.breed
    expect(page).to have_field :age, with: dog1.age
    # expect(page).to have_select('size', selected: dog1.size)
    expect(page).to have_content(dog1.size)
    # expect(page).to have_select('neutered', selected: dog1.neutered)
    expect(page).to have_content(dog1.neutered)
    expect(page).to have_button("Update")
    
    dog2 = DogsFacade.find_dog_by_id(1,2)
    visit edit_user_dog_path(1, 2)
    
    expect(page).to have_content('Editing Bob')
    expect(page).to have_field :name, with: dog2.name
    expect(page).to have_field :breed, with: dog2.breed
    expect(page).to have_field :age, with: dog2.age
    # expect(page).to have_select('size', selected: 'small')
    expect(page).to have_content(dog2.size)
    # expect(page).to have_select('neutered', selected: 'false')
    expect(page).to have_content(dog2.neutered)
    expect(page).to have_button("Update")
  end

  it 'when i fill out the edit form with my changes and click update,
    i am redirected to the user dog index and the information i updated appears', :vcr do 
    visit edit_user_dog_path(1, 1)
    dog1 = DogsFacade.find_dog_by_id(1,1)

    expect(page).to have_content("Editing #{dog1.name}")
    fill_in :age, with: "6"
    click_button("Update")
    # save_and_open_page
    expect(current_path).to eq(user_dogs_path(1))
    expect(page).to have_content("#{@user.name}'s Dogs")
    expect(page).to have_content("Name: Fido")
    expect(page).to have_content("Breed: Lab")
    expect(page).to have_content("Age: 6")
    expect(page).to have_content("Size: medium")
    expect(page).to have_content("Neutered: true")

    require 'pry'; binding.pry
    visit edit_user_dog_path(1, 2)

    expect(page).to have_content('Editing Bob')
    select "true", from: "Neutered"
    click_button("Update")
    
    expect(current_path).to eq(user_dogs_path(1))
    expect(page).to have_content("#{@user.name}'s Dogs")
    # within block to assure edit only changes just bobs age
    expect(page).to have_content("Name: Bob")
    expect(page).to have_content("Breed: Pug")
    expect(page).to have_content("Age: 3")
    expect(page).to have_content("Size: small")
    expect(page).to have_content("Neutered: true")

    # reset
    visit edit_user_dog_path(1, 1)
    fill_in :age, with: "5"
    click_button("Update")

    visit edit_user_dog_path(1, 2)
    select "false", from: "Neutered"
    click_button("Update")
  end

  it 'name field cant be left blank', :vcr do 
    visit edit_user_dog_path(1, 1)

    fill_in :name, with: ''
    expect(page).to have_field :breed, with: 'Lab'
    expect(page).to have_field :age, with: '5'
    expect(page).to have_select('size', selected: 'medium')
    expect(page).to have_select('neutered', selected: 'true')
    click_button("Update")

    expect(current_path).to eq(edit_user_dog_path(1, 1))
    expect(page).to have_content("**NO FIELDS CAN BE LEFT BLANK.**")
    
    visit edit_user_dog_path(1, 2)

    fill_in :name, with: ''
    expect(page).to have_field :breed, with: 'Pug'
    expect(page).to have_field :age, with: '3'
    expect(page).to have_select('size', selected: 'small')
    expect(page).to have_select('neutered', selected: 'false')
    click_button("Update")
    
    expect(current_path).to eq(edit_user_dog_path(1, 2))
    expect(page).to have_content("**NO FIELDS CAN BE LEFT BLANK.**")
  end

  it 'breed field cant be left blank', :vcr do 
    visit edit_user_dog_path(1, 1)

    expect(page).to have_field :name, with: 'Fido'
    fill_in :breed, with: ''
    expect(page).to have_field :age, with: '5'
    expect(page).to have_select('size', selected: 'medium')
    expect(page).to have_select('neutered', selected: 'true')
    click_button("Update")

    expect(current_path).to eq(edit_user_dog_path(1, 1))
    expect(page).to have_content("**NO FIELDS CAN BE LEFT BLANK.**")
    
    visit edit_user_dog_path(1, 2)

    expect(page).to have_field :name, with: 'Bob'
    fill_in :breed, with: ''
    expect(page).to have_field :age, with: '3'
    expect(page).to have_select('size', selected: 'small')
    expect(page).to have_select('neutered', selected: 'false')
    click_button("Update")
    
    expect(current_path).to eq(edit_user_dog_path(1, 2))
    expect(page).to have_content("**NO FIELDS CAN BE LEFT BLANK.**")
  end

  it 'age field cant be left blank', :vcr do 
    visit edit_user_dog_path(1, 1)

    expect(page).to have_field :name, with: 'Fido'
    expect(page).to have_field :breed, with: 'Lab'
    fill_in :age, with: ''
    expect(page).to have_select('size', selected: 'medium')
    expect(page).to have_select('neutered', selected: 'true')
    click_button("Update")

    expect(current_path).to eq(edit_user_dog_path(1, 1))
    expect(page).to have_content("**NO FIELDS CAN BE LEFT BLANK.**")
    
    visit edit_user_dog_path(1, 2)

    expect(page).to have_field :name, with: 'Bob'
    expect(page).to have_field :breed, with: 'Pug'
    fill_in :age, with: ''
    expect(page).to have_select('size', selected: 'small')
    expect(page).to have_select('neutered', selected: 'false')
    click_button("Update")
    
    expect(current_path).to eq(edit_user_dog_path(1, 2))
    expect(page).to have_content("**NO FIELDS CAN BE LEFT BLANK.**")
  end
end
