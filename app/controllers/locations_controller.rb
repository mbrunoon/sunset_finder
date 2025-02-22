class LocationsController < ApplicationController

    def show
        sunsets = Sunset.at_location_list(get_params)
        render json: sunsets
    end


    private

    def get_params
        params.permit(:name, :date_start, :date_end)
        {
            name: params[:name],
            date_start: params[:date_start] || Date.today,
            date_end: params[:date_end] || Date.today
        }
    end

end
