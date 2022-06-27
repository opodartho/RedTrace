require 'rails_helper'

RSpec.describe 'Manager sees Companies' do
  it 'entries of all' do
    manager = create(:manager, password: 'secret')

    sign_in manager

    visit admin_root_url(subdomain: 'admin')

    click_on 'Companies'

    expect(page).to have_text 'Companies'
  end
end
