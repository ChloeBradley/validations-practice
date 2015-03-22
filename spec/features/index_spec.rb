require 'rails_helper'

feature 'index and model validations' do
  scenario 'user can visit index page' do
    visit root_path

    expect(page).to have_content 'Accounts:'
  end

  scenario 'user is not able to create a new account with invalid params' do
    visit root_path

    click_on 'Create a new Account!'

    fill_in 'Name', with: ""
    fill_in 'Age', with: "150"
    fill_in 'Birth date', with: "02/03/2016"
    fill_in 'Favorite school', with: "DeVry University"
    click_on 'Create Account'

    expect(page).to have_content "Name can't be blank"
    expect(page).to have_content "Age must be less than 100"
    expect(page).to have_content "You can't be born in the future!"
    expect(page).to have_content "The correct answer here is gSchool"
    expect(page).to have_content "You must agree to the Terms of Service. No one knows what's in it. It should be okay..."
  end

  scenario 'user is able to create a new account with valid params' do
    visit root_path

    click_on 'Create a new Account!'

    fill_in 'Name', with: "Scotch"
    fill_in 'Age', with: "50"
    fill_in 'Birth date', with: "20/03/1965"
    fill_in 'Favorite school', with: "gSchool"
    check 'Terms of service'
    click_on 'Create Account'

    expect(page).to have_content "Thanks for making an account! You really shouldn't have agreed to the ToS =) "
  end
end
