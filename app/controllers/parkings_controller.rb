class ParkingsController < ApplicationController

  def index
    @parkings = ["park1", "park2"]
    render json: @parkings
  end

  def show
  end

  def create
  end

  def parking_info
    # This is a dummy json response to check with the mobile app.
    @parking = ["hello", "there"]
    render json: @parking
  end

  
end
