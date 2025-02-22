class Sunset < ApplicationRecord
    scope :by_location, ->(location) { where(location: location.downcase) }

    def self.at_location_list(params = {})
        raise StandardError, "Location must be informed" if params.values.any?(&:blank?)
    
        location = params[:name].downcase
        date_start = params[:date_start].to_date
        date_end = params[:date_end].to_date

        sunsets = []

        (date_start..date_end).each do |date|
            sunset = by_location(location).where(occurs_at: date).first
            if sunset.blank?
                sunset = self.register_sunset(location, date)
            end

            sunsets << sunset
        end

        sunsets
    rescue StandardError => e
        Rails.logger.error(e.message)
        { error: e.message }
    end


    private

    def self.register_sunset(location, date)
        lat, lon = GeocodeApiService.get_coordinate(location)
        raise StandardError, "GeocodeApiService don´t respond" if lat.nil? || lon.nil?

        sunsetApi = SunsetApiService.new(lat: lat, lng: lon, date_start: date, date_end: date)

        sunset_data = sunsetApi.get_sunset
        
        raise StandardError, "SunsetApiService don´t respond" if sunset_data.blank?

        create({
            location: location,
            occurs_at: date,
            data: sunset_data.first
        })
    rescue StandardError => e
        Rails.logger.error(e.message)
        { error: e.message }
    end
end
