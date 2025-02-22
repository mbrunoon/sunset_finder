require 'net/http'
require 'json'

class GeocodeApiService

    BASE_URL = "https://geocode.maps.co"
    API_KEY = ENV.fetch("GEOCODE_KEY") { "" }

    def self.get_coordinate(location)
        raise StandardError, "Location must be informed" if location.nil?

        resJson = fetch_data_json(location: location)
        get_lat_lng(resJson)
    rescue StandardError => e
        Rails.logger.error(e.message)
        {error: e.message}
    end

    private

    def self.get_lat_lng(response)
        [
            response[0].fetch("lat"),
            response[0].fetch("lon")
        ]
    rescue StandardError => e
        Rails.logger.error(e.message)
        {error: e.message}
    end

    def self.fetch_data_json(location: nil)
        raise StandardError, "Location can't be blank" if location.blank?

        uri = URI("#{BASE_URL}/search?q=#{location}&api_key=#{API_KEY}")
        response = Net::HTTP.get(uri)
        jsonResponse = JSON.parse(response)
        raise StandardError, "Location not found" if jsonResponse.length == 0

        jsonResponse
    rescue StandardError => e
        Rails.logger.error(e.message)
        {error: e.message}
    end

end