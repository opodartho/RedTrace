require 'test_helper'

class CompaniesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @company = build(:company)
  end
  test 'should get index' do
    get companies_url
    assert_response :success
  end

  test 'should get new' do
    get new_company_url
    assert_response :success
  end

  test 'should create company' do
    assert_difference ['Company.count', 'User.count'] do
      post companies_url, params: { company: { name: @company.name, subdomain: @company.subdomain } }
    end
  end
end
