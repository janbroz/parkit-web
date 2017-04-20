class ParkingsController < ApplicationController

  before_action :authenticate_user!
  
  def index
    @parkings = Parking.all

    
    
    #render json: @parkings
  end

  def show
    @parking = Parking.find(params[:id])
    
  end

  def new

  end

  def destroy
    @parking = Parking.find(params[:id])
    @parking.destroy
    redirect_to '/parkings', :notice => "Parking was deleted"
  end

  def create
    @parking = Parking.new(parking_params)
    @parking.save
    redirect_to @parking
    #render plain: params[:parking].inspect
  end

  def parking_info
    @parking = Parking.find(params[:id])
    #@parking = ["hello", "there"] We can use a dummy json here while the full functionality is implemented.
    render json: @parking
  end

  private
  def parking_params
    params.require(:parking).permit(:name, :description)
  end
  
end
