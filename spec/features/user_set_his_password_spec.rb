require 'rails_helper'

RSpec.describe 'User set his password' do
  it 'they see their dashboard' do
    user = create(:user)
    password = 'secret'

    visit root_url(subdomain: user.company.subdomain)

    click_on 'Set Password'

    fill_in 'Msisdn', with: user.msisdn

    click_on 'Send OTP'

    # reload the user as after sending otp user object needed to be sync
    user.reload

    otp = GenerateOtp.call(
      sent_at: user.otp_confirmation_sent_at,
      token: user.otp_confirmation_token,
    ).result

    fill_in 'Otp', with: otp

    click_on 'Submit'

    fill_in 'New password', with: password
    fill_in 'Confirm new password', with: password

    click_on 'Change my password'

    expect(page).to have_text 'Dashboard'
  end
end
