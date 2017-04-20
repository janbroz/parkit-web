class ParkingsController < ApplicationController

  before_action :authenticate_user!, except: [:parking_info]
  
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
    #@parking = Parking.find(params[:id])
    #@parking = ["hello", "there"] We can use a dummy json here while the full functionality is implemented.
    park = { "parqueaderos": [
                               {
                                 "x":0,
                                 "y":0,
                                 "estado":"F",
                                "direccion":"D"
                               },
                               {
                                 "x":1,
                                 "y":1,
                                 "estado":"F",
                                "direccion":"D"
                               },
                               {                              
                                 "x":1,
                                 "y":2,
                                 "estado":"F",
                                "direccion":"D"
                               }
                             ]}

    render json: park
    #render json: @parking
  end

  private
  def parking_params
    params.require(:parking).permit(:name, :description)
  end
  
end
