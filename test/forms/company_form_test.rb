require 'test_helper'

class CompanyFormTest < ActiveSupport::TestCase
  test 'company attributes must not be empty' do
    form = CompanyForm.new
    assert form.invalid?
    assert form.errors[:name].any?
    assert form.errors[:subdomain].any?
    assert form.errors[:owner_name].any?
    assert form.errors[:msisdn].any?
  end

  test 'msisdn must be valid' do
    form = CompanyForm.new(name: 'Test', subdomain: 'subdomain', owner_name: 'owner')

    form.msisdn = '01833111111'
    assert form.invalid?
    assert_equal ['must be a valid msisdn'], form.errors[:msisdn]
    form.msisdn = '0183311111'
    assert form.invalid?
    assert_equal ['must be a valid msisdn'], form.errors[:msisdn]
    form.msisdn = '+8801833111111'
    assert form.invalid?
    assert_equal ['must be a valid msisdn'], form.errors[:msisdn]
    form.msisdn = '018331111111'
    assert form.invalid?
    assert_equal ['must be a valid msisdn'], form.errors[:msisdn]

    form.msisdn = '8801833111111'
    assert form.valid?
  end

  test 'subdomain must be valid' do
    form = CompanyForm.new(name: 'Test', owner_name: 'owner', msisdn: '8801833111111')

    form.subdomain = '@subdomain'
    assert form.invalid?
    assert_equal ['must be a valid subdomain'], form.errors[:subdomain]
    form.subdomain = 'subdomain-'
    assert form.invalid?
    assert_equal ['must be a valid subdomain'], form.errors[:subdomain]
    form.subdomain = 'sub domain'
    assert form.invalid?
    assert_equal ['must be a valid subdomain'], form.errors[:subdomain]

    form.subdomain = 'subdomain'
    assert form.valid?
  end
end
