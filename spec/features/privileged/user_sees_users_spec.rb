require 'rails_helper'

RSpec.describe 'User sees users' do
  it 'entries of all' do
    user = create(:user)

    sign_in user

    visit root_url(subdomain: user.company.subdomain)

    click_on 'Users'

    expect(page).to have_text 'Users'
  end
end
