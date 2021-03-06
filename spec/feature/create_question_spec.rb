require 'rails_helper'

feature 'Create question', %q{
  In order to get answer from comunity
  As an auth user
  I want to be able to ask questions
} do
  given(:user) { create(:user) }

  scenario 'Auth user create question' do
    sign_in_user(user)

    visit questions_path
    click_on 'Ask question'
    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'text text'
    click_on 'Create'

    expect(page).to have_content 'Your question successfully created.'
  end

  scenario 'Non-Auth user tries to create question' do
    visit questions_path
    click_on 'Ask question'

    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end
end
