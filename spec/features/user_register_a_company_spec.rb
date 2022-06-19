require 'rails_helper'

RSpec.describe 'User register a company' do
  it 'they see the page for password set' do
    company_name = 'Reddot'
    company_subdomain = 'reddot'
    company_manager_name = 'Zahidul Haque'
    company_manager_contact = '8801833182696'

    visit root_path

    click_on 'Create Company'
    fill_in 'company_form_company_attributes_name', with: company_name
    fill_in 'company_form_company_attributes_subdomain', with: company_subdomain
    fill_in 'company_form_user_attributes_name', with: company_manager_name
    fill_in 'company_form_user_attributes_msisdn', with: company_manager_contact
    check 'Terms of service'

    click_on 'Create Company form'

    expect(page).to have_text 'Set Password'
  end
end
