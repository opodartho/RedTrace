require 'rails_helper'

RSpec.describe 'User creates a new user' do
  it 'they see list of users' do
    user_name = 'Zahidul Haque'
    user_contact = '8801833182696'

    user = create(:user)

    sign_in user

    visit root_url(subdomain: user.company.subdomain)

    click_on 'Users'
    
    expect(page).to have_text 'Users'

    click_on 'New user'

    fill_in 'user_name', with: user_name
    fill_in 'user_msisdn', with: user_contact

    click_on 'Create User'
  end
end
