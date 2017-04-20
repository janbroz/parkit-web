class ParkingsController < ApplicationController

  def index
    @parkings = Parking.all

    
    
    #render json: @parkings
  end

  def show
  end

  def new

  end

  def create
    render plain: params[:parking].inspect
  end

  def parking_info
    # This is a dummy json response to check with the mobile app.
    @parking = ["hello", "there"]
    render json: @parking
  end

  
end
