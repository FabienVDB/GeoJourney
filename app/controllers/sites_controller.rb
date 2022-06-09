class SitesController < ApplicationController
  before_action :set_itinerary, only: [:new, :create, :destroy, :edit, :update]

  def new
    @itinerary = Itinerary.find(params[:itinerary_id])
    @site = Site.new
  end

  def create
    @itinerary = Itinerary.find(params[:itinerary_id])
    @site = @itinerary.sites.new(site_params)
    if @site.save
      redirect_to itinerary_path(@itinerary)
    else
      render :new
    end
  end

  def edit
    @site = Site.find(params[:id])
  end

  def update
    @site = Site.find(params[:id])
    if @site.update(site_params)
      redirect_to itinerary_path(@site.itinerary)
    else
      render :edit
    end
  end

  private

  def set_itinerary
    @itinerary = Itinerary.find(params[:itinerary_id])
  end

  def site_params
    params.require(:site).permit(:name, :summary, :content, :duration_in_minutes, :stage, :location, :latitude, :longitude)
  end
end
