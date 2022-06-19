require 'rails_helper'

RSpec.describe 'Manger login to admin panel' do
  scenario 'they see page with Back to app link' do
    manager = create(:manager, password: 'secret')

    visit admin_root_url(subdomain: 'admin')

    fill_in 'Username', with: manager.username
    fill_in 'Password', with: 'secret'

    click_on 'Log in'

    expect(page).to have_link 'Back to app'
  end
end
