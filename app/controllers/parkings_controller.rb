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

    park = {
      "parqueaderos":
              [
                {
                  "x":0,
                  "y":0,
                  "estado":"E",
                 "direccion":"U"
                },
                {
                  "x":1,
                  "y":0,
                  "estado":"F",
                 "direccion":"U"
                },
                {
                  "x":2,
                  "y":0,
                  "estado":"F",
                 "direccion":"U"
                },
                {
                  "x":3,
                  "y":0,
                  "estado":"F",
                 "direccion":"U"
                },
                {
                  "x":4,
                  "y":0,
                  "estado":"E",
                 "direccion":"U"
                },
                {
                  "x":5,
                  "y":0,
                  "estado":"F",
                 "direccion":"U"
                },
                {
                  "x":6,
                  "y":0,
                  "estado":"S",
                 "direccion":"U"
                },
                {
                  "x":7,
                  "y":0,
                  "estado":"F",
                 "direccion":"L"
                },
                {
                  "x":0,
                  "y":1,
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
                  "x":2,
                  "y":1,
                  "estado":"F",
                 "direccion":"D"
                },
                {
                  "x":3,
                  "y":1,
                  "estado":"E",
                 "direccion":"D"
                },
                {
                  "x":4,
                  "y":1,
                  "estado":"F",
                 "direccion":"D"
                },
                {
                  "x":5,
                  "y":1,
                  "estado":"F",
                 "direccion":"D"
                },
                {
                  "x":6,
                  "y":1,
                  "estado":"S",
                 "direccion":"U"
                },
                {
                  "x":7,
                  "y":1,
                  "estado":"E",
                 "direccion":"L"
                },
                {
                  "x":0,
                  "y":2,
                  "estado":"S",
                 "direccion":"U"
                },
                {
                  "x":1,
                  "y":2,
                  "estado":"S",
                 "direccion":"U"
                },
                {
                  "x":2,
                  "y":2,
                  "estado":"S",
                 "direccion":"U"
                },
                {
                  "x":3,
                  "y":2,
                  "estado":"S",
                 "direccion":"U"
                },
                {
                  "x":4,
                  "y":2,
                  "estado":"S",
                 "direccion":"U"
                },
                {
                  "x":5,
                  "y":2,
                  "estado":"S",
                 "direccion":"U"
                },
                {
                  "x":6,
                  "y":2,
                  "estado":"S",
                 "direccion":"U"
                },
                {
                  "x":0,
                  "y":3,
                  "estado":"F",
                 "direccion":"D"
                },
                {
                  "x":1,
                  "y":3,
                  "estado":"F",
                 "direccion":"D"
                },
                {
                  "x":2,
                  "y":3,
                  "estado":"F",
                 "direccion":"D"
                },
                {
                  "x":3,
                  "y":3,
                  "estado":"E",
                 "direccion":"D"
                },
                {
                  "x":4,
                  "y":3,
                  "estado":"F",
                 "direccion":"D"
                },
                {
                  "x":5,
                  "y":3,
                  "estado":"E",
                 "direccion":"R"
                }
              ]
    }

    
    # park = { "parqueaderos": [
    #                            {
    #                              "x":0,
    #                              "y":0,
    #                              "estado":"F",
    #                             "direccion":"D"
    #                            },
    #                            {
    #                              "x":1,
    #                              "y":1,
    #                              "estado":"F",
    #                             "direccion":"D"
    #                            },
    #                            {                              
    #                              "x":1,
    #                              "y":2,
    #                              "estado":"F",
    #                             "direccion":"D"
    #                            }
    #                          ]}

    render json: park
    #render json: @parking
  end

  private
  def parking_params
    params.require(:parking).permit(:name, :description)
  end
  
end
