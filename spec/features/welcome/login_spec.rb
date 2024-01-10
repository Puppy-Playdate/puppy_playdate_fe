require 'rails_helper'

RSpec.describe 'User Login' do
  it 'exists' do 
    visit root_path

    expect(page).to have_content("Puppy Playdate")
    expect(page).to have_link('Login')
    expect(page).to have_link('New User')
    expect(page).to have_link('Home')
  end

  it 'routes a user to a new user form page' do 
    visit root_path

    click_link('New User')
    expect(current_path).to eq(new_user_path)
  end 

  it 'routes a user to a socials index page' do 
    visit root_path

    click_button('View all Socials')
    expect(current_path).to eq(socials_path)
  end 
  
  it 'logs-in existing users' do 
    visit root_path 
    
    click_link('Login')
    expect(current_path).to eq(login_path)
    
    expect(page).to have_field :name 
    expect(page).to have_field :email 
    expect(page).to have_field :password 
    expect(page).to have_button('Login')
    expect(page).to have_button('Login with Google')
  end

  it "Nav bar changes based on if someone is logged in", :vcr do
    visit root_path

    click_link("Create New User")

    fill_in :name, with: "Eric"
    fill_in :email, with: "alabama@shakes.com"
    fill_in :password, with: "SuperSecret"
    fill_in :password_confirmation, with: "SuperSecret"
    click_button("Create New User")

    expect(page).to have_content("Account Created")
    expect(page).to have_content("Eric")
    expect(page).to have_content("alabama@shakes.com")

    expect(page).to have_link("Home")
    expect(page).to have_link("My Dashboard")
    expect(page).to have_link("Log out")
    expect(page).to_not have_link("Create New User")
    expect(page).to_not have_link("Login")

    click_link("Log out")
    expect(current_path).to eq(root_path)
    expect(page).to have_link("Home")
    expect(page).to_not have_link("My Dashboard")
    expect(page).to_not have_link("Log out")
    expect(page).to have_link("Create New User")
    expect(page).to have_link("Login")
  end
end 
