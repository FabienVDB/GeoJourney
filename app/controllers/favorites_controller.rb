class FavoritesController < ApplicationController
  def create
    @itinerary = Itinerary.find(params[:itinerary_id])
    @favorite = Favorite.new(user: current_user, itinerary: @itinerary)
    @favorite.save
    respond_to do |format|
      format.js
      format.html { redirect_to itineraries_path }
    end
  end

  def destroy
    @favorite = Favorite.find(params[:id])
    @favorite.destroy
    @itinerary = @favorite.itinerary
    respond_to do |format|
      format.js { render :create }
      format.html { redirect_to itineraries_path }
    end
  end
end
