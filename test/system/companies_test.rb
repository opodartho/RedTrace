require "application_system_test_case"

class CompaniesTest < ApplicationSystemTestCase
  setup do
    @company = build(:company)
  end

  test "visit companies index page" do
    visit companies_url
    assert_selector "h1", text: "Companies"
  end

  test "should create company" do
    visit companies_url
    click_on "New company"

    fill_in "Name", with: @company.name
    fill_in "Subdomain", with: @company.subdomain
    click_on "Create Company"

    assert_text "Company was successfully created"
    click_on "Back"
  end
end