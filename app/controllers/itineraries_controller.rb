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
        # info_window: render_to_string(partial: "shared/card_itinerary_index", locals: { itinerary: itinerary }),
        info_window: render_to_string(partial: "shared/info_window_itinerary", locals: { itinerary: itinerary }),
        image_url: helpers.cl_image_path(itinerary.photo.key)
      }
    end

    @markers = @itineraries_for_mapbox.map { |i| i[:sites] }.flatten
  end

  def show
    @itinerary = Itinerary.find(params[:id])
  end
end
