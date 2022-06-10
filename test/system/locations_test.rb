require 'application_system_test_case'

class LocationsTest < ApplicationSystemTestCase
  setup do
    sign_in create(:user)
    @location = build(:location)
  end

  test 'visiting the index' do
    skip
    visit locations_url
    assert_selector 'h1', text: 'Locations'
  end

  test 'should create location' do
    skip
    visit locations_url
    click_on 'New location'

    fill_in 'Latitude', with: @location.latitude
    fill_in 'Longitude', with: @location.longitude
    click_on 'Create Location'

    assert_text 'Location was successfully created'
    click_on 'Back'
  end

  test 'should update Location' do
    skip
    visit location_url(@location)
    click_on 'Edit this location', match: :first

    fill_in 'Latitude', with: @location.latitude
    fill_in 'Longitude', with: @location.longitude
    click_on 'Update Location'

    assert_text 'Location was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Location' do
    skip
    visit location_url(@location)
    click_on 'Destroy this location', match: :first

    assert_text 'Location was successfully destroyed'
  end
end
