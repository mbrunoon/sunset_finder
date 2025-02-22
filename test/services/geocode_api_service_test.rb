require "test_helper"

class GeocodeApiServiceTest < ActiveSupport::TestCase
    test "should return Porto coordinate" do
        location = "Porto"
        coordinate = GeocodeApiService.get_coordinate(location: location)
        
        assert_not_empty coordinate
    end
end
