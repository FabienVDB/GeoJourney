class ItinerariesController < ApplicationController
  def index
    if params[:area].present?
      @itineraries = Itinerary.search(params[:area])
    else
      @itineraries = Itinerary.all
    end
  end
end
