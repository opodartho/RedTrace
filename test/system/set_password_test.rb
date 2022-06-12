require 'application_system_test_case'

class SetPasswordTest < ApplicationSystemTestCase
  setup do
    @company = create(:company)
    @user = create(:user, company: @company)
    switch_to_subdomain(@company.subdomain)
  end

  test 'visit send otp page' do
    visit new_user_otp_path(subdomain: @company.subdomain)
    assert_button 'Send OTP'
  end

  test 'send and verify otp' do
    visit new_user_otp_path(subdomain: @company.subdomain)

    fill_in 'Msisdn', with: @user.msisdn

    click_on 'Send OTP'

    assert_current_path verify_form_user_otp_path(msisdn: @user.msisdn, subdomain: @company.subdomain)

    @user.reload
    otp = GenerateOtp.call(sent_at: @user.otp_confirmation_sent_at, token: @user.otp_confirmation_token).result

    fill_in 'Otp', with: otp

    click_on 'Submit'

    assert_selector 'h2', text: 'Change your password'
  end
end
