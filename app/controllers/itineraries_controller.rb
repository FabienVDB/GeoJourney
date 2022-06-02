class ItinerariesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    if params[:area].present?
      @itineraries = Itinerary.search(params[:area])
    else
      @itineraries = Itinerary.all
    end

    @markers = @itineraries.first.sites.map do |site|
      {
        lat: site.latitude,
        lng: site.longitude
      }
    end

    @coordinates = @itineraries.map do |itinerary|
      itinerary.sites.map do |site|
        {
          lat: site.latitude,
          lng: site.longitude
        }
      end
    end
  end

  def show
    @itinerary = Itinerary.find(params[:id])
  end
end
