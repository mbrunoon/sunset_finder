require "test_helper"

class SunsetApiServiceTest < ActiveSupport::TestCase
    test "should return Porto Sunset" do
        lat = 41.15
        lng = -8.61024

        apiSunset = SunsetApiService.new(lat: lat, lng: lng)
        response = apiSunset.fetch_data

        assert_not_empty response
    end

    test "should return error response" do
        apiSunset = SunsetApiService.new(lat: nil, lng: nil)
        response = apiSunset.fetch_data

        assert_not_empty response[:error]
    end
end
