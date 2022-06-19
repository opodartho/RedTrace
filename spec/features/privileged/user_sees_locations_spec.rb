require 'rails_helper'

RSpec.describe 'User sees locations' do
  it 'entries of all' do
    user = create(:user)

    sign_in user

    visit root_url(subdomain: user.company.subdomain)

    click_on 'Locations'

    expect(page).to have_text 'Locations'
  end
end
