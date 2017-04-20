class ParkingsController < ApplicationController

  def index
    @parkings = Parking.all

    
    
    #render json: @parkings
  end

  def show
    @parking = Parking.find(params[:id])
    
  end

  def new

  end

  def create
    @parking = Parking.new(parking_params)
    @parking.save
    redirect_to @parking
    #render plain: params[:parking].inspect
  end

  def parking_info
    # This is a dummy json response to check with the mobile app.
    @parking = ["hello", "there"]
    render json: @parking
  end

  private
  def parking_params
    params.require(:parking).permit(:name, :description)
  end
  
end
