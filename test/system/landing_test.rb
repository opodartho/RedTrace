require 'application_system_test_case'

class LandingTest < ApplicationSystemTestCase
  test 'visit public landing page' do
    visit root_url
    assert_selector 'h1', text: 'Home#Index'
    assert_link 'Create Company'
  end
end
