require 'net/http'
require 'json'

class SunsetApiService

    BASE_URL = "https://api.sunrisesunset.io/json"

    def initialize(lat:, lng:, date_start: nil, date_end: nil)
        @lat = lat
        @lng = lng
        @date_start = date_start
        @date_end = date_end
    end


    def get_sunset
        raise StandardError, "Latitude and Longitude are required" if @lat.nil? || @lng.nil?

        uri = URI("#{BASE_URL}?lat=#{@lat}&lng=#{@lng}")
        if @date_start.present? && @date_end.present?
            uri.query += "&date_start=#{@date_start}&date_end=#{@date_end}"
        end

        response = Net::HTTP.get(uri)
        jsonResponse = JSON.parse(response)
        
        response_data(jsonResponse)
    rescue  StandardError => e
        Rails.logger.error(e.message)
        {error: e.message}
    end

    private

    def response_data(response)
        return response.fetch("results") if response["status"] == "OK"

        raise StandardError, "Sunset API error: #{response}"
    rescue StandardError => e
        Rails.logger.error(e.message)
        {error: e.message}
    end
end