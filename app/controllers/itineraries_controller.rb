class ItinerariesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @areas = Area.all
    @themes = Theme.all
    if params[:search].present?
      areas = selections('area')
      themes = selections('theme')

      @itineraries_by_areas = itineraries_by_multiple(areas)
      @itineraries_by_themes = itineraries_by_multiple(themes)

      @itineraries = @itineraries_by_areas.intersection(@itineraries_by_themes)

    else
      @itineraries = Itinerary.all
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
  end

  def show
    @itinerary = Itinerary.find(params[:id])
  end

  private

  def selections(params_key)
    values = params[:search][params_key.to_s].reject(&:empty?)
    values = params_key.capitalize.constantize.all.map(&:name) if values.empty?
    values
  end

  def itineraries_by_multiple(selections)
    @itineraries_by_selections = []
    selections.each { |selection| @itineraries_by_selections += Itinerary.global_search(selection) }
    @itineraries_by_selections
  end
end
