class ItinerariesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @areas = Area.all
    @themes = Theme.all
    if params[:search].present?
      areas = params[:search][:area].reject(&:empty?)
      if areas.size == 1
        @itineraries = Itinerary.global_search(params[:search][:area].reject(&:empty?).first)
      else
        @itineraries = areas.map { |area| Itinerary.global_search(area).first }
      end
      themes = params[:search][:theme].reject(&:empty?)
      if themes.size == 1
        @itineraries = Itinerary.global_search(params[:search][:theme].reject(&:empty?).first)
      else
        @itineraries = themes.map { |theme| Itinerary.global_search(theme).first }
      end

    else
      @itineraries = Itinerary.all
    end

    @coordinates = @itineraries.map do |itinerary|
      {
        name: itinerary.name,
        summary: itinerary.summary,
        sites: itinerary.sites.sort_by(&:stage).map { |s| { lat: s.latitude, lng: s.longitude } }
      }
    end

    @markers = @coordinates.map { |i| i[:sites] }.flatten
  end

  def show
    @itinerary = Itinerary.find(params[:id])
  end
end
