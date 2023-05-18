class Admin::PlacesController < ApplicationController
before_action :authenticate_admin!

  def index
   @place = Place.new
   @places = Place.all
  end

  def create
   place = Place.new(place_params)
    if place.save
      redirect_to admin_places_path
    else
      @place = place
      @places = Place.all
      render :index
    end
  end

  def edit
    @place = Place.find(params[:id])
  end

  def update
    place = Place.find(params[:id])
    if place.update(place_params)
    redirect_to admin_places_path
    else
    redirect_to edit_admin_places_path
    end
  end


private

def place_params
  params.require(:place).permit(:prefectures)
end

end
