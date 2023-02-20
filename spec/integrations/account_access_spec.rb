# frozen_string_literal: true

require 'rails_helper'

describe 'Access control system', type: :feature do
  it 'allows a user to edit own account', js: false do
    create_user
    signin
    click_on 'My account'
    click_on 'Edit'
    fill_in 'Email', with: 'new_address@email.com'
    fill_in 'Password', with: PASSWORD
    click_on 'Submit'
    expect(page.body).to include('new_address@email.com')
  end

  it 'does not allow access to any account unless authenticated' do
    visit "/users/#{create_user.id}/"
    expect(page.body).not_to include(USERNAME)
  end

  it 'does not allow editing any account unless authenticated' do
    visit "/users/#{create_user.id}/edit"
    expect(page.body).not_to include(USERNAME)
  end
end
