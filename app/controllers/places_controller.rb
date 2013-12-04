class PlacesController < ApplicationController
  respond_to :html

  def index
    @places = Place.all
    respond_with @places
  end

  def show
    @place = Place.find(params[:id])
    respond_with @place
  end

  def new
    @place = Place.new
    respond_with @place
  end

  def edit
    @place = Place.find(params[:id])
  end

  def create
    @place = Place.new(params[:place])

    respond_to do |format|
      if @place.save
        format.html { redirect_to @place, notice: 'Place was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @place = Place.find(params[:id])

    respond_to do |format|
      if @place.update_attributes(params[:place])
        format.html { redirect_to @place, notice: 'Place was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @place = Place.find(params[:id])
    @place.destroy
    redirect_to places_url
  end
end
