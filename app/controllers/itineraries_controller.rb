class ItinerariesController < ApplicationController

  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    if params[:area].present?
      @itineraries = Itinerary.search(params[:area])
    else
      @itineraries = Itinerary.all
    end
  end

  def show
    @itinerary = Itinerary.find(params[:id])
  end

end
