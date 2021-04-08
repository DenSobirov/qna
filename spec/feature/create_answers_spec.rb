require 'rails_helper'

feature 'User answer', %q{
  In order to exchange my knowledge
  As an auth user
  I want to be able to create answers
} do
  given(:user) { create(:user) }
  given(:question) { create(:question) }

  scenario 'Auth user create answer', js: true do
    sign_in_user(user)

    visit question_path(question)

    fill_in 'Your answer', with: 'My answer'
    click_on 'Give an answer'

    expect(current_path).to eq question_path(question)
    within '.answers' do
      expect(page).to have_content 'My answer'
    end
  end

  scenario 'Non-Auth user tries to create question' do
    visit questions_path
    click_on 'Ask question'

    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end
end
