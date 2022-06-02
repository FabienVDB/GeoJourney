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

    @itineraries_for_mapbox = @itineraries.map do |itinerary|
      {
        name: itinerary.name,
        summary: itinerary.summary,
        sites: itinerary.sites.sort_by(&:stage).map { |s| { stage: s.stage, lat: s.latitude, lng: s.longitude } },
        info_window: render_to_string(partial: "shared/card_itinerary_index", locals: { itinerary: itinerary })
      }
    end

    @markers = @itineraries_for_mapbox.map { |i| i[:sites] }.flatten
  end

  def show
    @itinerary = Itinerary.find(params[:id])
  end
end
