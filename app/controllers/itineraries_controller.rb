class ItinerariesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @areas = Area.all
    @themes = Theme.all
    @durations = Itinerary.all.map(&:duration_in_days).uniq.sort.map { |d| Duration.new(d) }
    if params[:search].present?
      @itineraries = filter_itineraries
    else
      @itineraries = Itinerary.all.sort_by(&:id)
    end

    @itineraries_for_mapbox = itineraries_to_json(@itineraries)
  end

  def edit
    @itinerary = Itinerary.find(params[:id])
  end

  def new
    @itinerary = Itinerary.new
    @site = Site.new
  end

  def create
    @itinerary = Itinerary.new(itinerary_params)
    @itinerary.user = current_user
    if @itinerary.save
      redirect_to itinerary_path(@itinerary)
    else
      render :new
    end
  end

  def show
    @itinerary = Itinerary.find(params[:id])
    @sites_for_mapbox = sites_to_json(@itinerary)
  end

  def update
    @itinerary = Itinerary.find(params[:id])
    @itinerary.update(itinerary_params)
    redirect_to itinerary_path(@itinerary)
  end

  def destroy
    @itinerary = Itinerary.find(params[:id])
    @itinerary.destroy
    redirect_to itineraries_path(@itinerary)
  end

  private

  def itinerary_params
    params.require(:itinerary).permit(:name, :summary, :duration_in_days, :photo, :area_id, :theme_id, sites_attributes: [:id, :name, :stage, :location, :content, :photo, :summary, :duration_in_minutes, :_destroy])
  end

  def filter_itineraries
    areas = selections(:areas, :name)
    themes = selections(:themes, :name)
    durations = selections(:durations, :days)

    itineraries_by_areas = filter_by(areas)
    itineraries_by_themes = filter_by(themes)
    itineraries_by_durations = filter_by(durations)

    itineraries_by_areas.intersection(itineraries_by_themes, itineraries_by_durations)
  end

  def selections(params_key, field)
    values = params[:search][params_key].reject(&:empty?)
    if params_key == :durations && values.empty?
      values = @durations.map { |s| s.public_send(field) }
    elsif params_key == :durations
      values = values.map(&:to_i)
    elsif values.empty?
      values = params_key.to_s.chop.capitalize.constantize.all.map { |s| s[field] }
    end
    values
  end

  def filter_by(selections)
    filtered_itineraries = []
    selections.each { |selection| filtered_itineraries += Itinerary.global_search(selection) }
    filtered_itineraries
  end

  # def itineraries_to_json(itineraries)
  #   itineraries.map do |itinerary|
  #     {
  #       name: itinerary.name,
  #       summary: itinerary.summary,
  #       sites: itinerary.sites.sort_by(&:stage).map { |s| { stage: s.stage, lat: s.latitude, lng: s.longitude } },
  #       # info_window: render_to_string(partial: "shared/card_itinerary_index", locals: { itinerary: itinerary }),
  #       info_window: render_to_string(partial: "shared/info_window_itinerary", locals: { itinerary: itinerary }),
  #       image_url: helpers.cl_image_path(itinerary.photo.key)
  #     }
  #   end.to_json
  # end

  def itineraries_to_json(itineraries)
    itineraries.map do |itinerary|
      {
        id: itinerary.id,
        name: itinerary.name,
        summary: itinerary.summary,
        coords: itinerary.sites.sort_by(&:stage).map { |s| [s.longitude, s.latitude] },
        info_window: render_to_string(partial: "shared/info_window_itinerary", locals: { itinerary: itinerary }),
        image_url: itinerary.photo.attached? ? helpers.cl_image_path(itinerary.photo.key, width: 100, height: 100, crop: :fill) : helpers.cl_image_path(Itinerary.first.photo.key, width: 100, height: 100, crop: :fill)
      }
    end.to_json
  end

  def sites_to_json(itinerary)
    output = {}
    output[:id] =  itinerary.id,
    output[:name] = itinerary.name,
    output[:sites] = itinerary.sites.sort_by(&:stage).map do |site|
      {
        id: site.id,
        name: site.name,
        summary: site.summary,
        coords: [site.longitude, site.latitude],
        duration_in_minutes: site.duration_in_minutes,
        info_window: render_to_string(partial: "shared/info_window_site", locals: { site: site }),
        image_url: site.photo.attached? ? helpers.cl_image_path(site.photo.key, width: 100, height: 100, crop: :fill) : helpers.cl_image_path(Itinerary.first.sites.first.photo.key, width: 100, height: 100, crop: :fill)
      }
    end
    output[:coords] = itinerary.sites.sort_by(&:stage).map { |s| [s.longitude, s.latitude] }
    output[:durations_in_minutes] = itinerary.sites.sort_by(&:stage).map(&:duration_in_minutes)
    output.to_json
  end

  class Duration
    attr_accessor :days

    def initialize(days)
      @days = days
    end

    def to_s
      "#{days} day#{days > 1 ? 's' : ''}"
    end
  end
end
