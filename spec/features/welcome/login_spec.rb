require 'rails_helper'

RSpec.describe 'User Login' do
  it 'exists' do 
    visit root_path

    expect(page).to have_button('Login')
    expect(page).to have_button('New User')
    expect(page).to have_button('View Socials')
  end

  it 'routes a user to a new user form page' do 
    visit root_path

    click_button('New User')
    expect(current_path).to eq(new_user_path)
  end 

  it 'routes a user to a socials index page' do 
    visit root_path

    click_button('View Socials')
    expect(current_path).to eq(socials_path)
  end 
  
  it 'logs-in existing users' do 
    visit root_path 
    
    click_button('Login')
    expect(current_path).to eq(login_path)
    
    expect(page).to have_field :full_name 
    expect(page).to have_field :email 
    expect(page).to have_field :password 
    expect(page).to have_button('Login')
    expect(page).to have_button('Login with Google')
  end
end 