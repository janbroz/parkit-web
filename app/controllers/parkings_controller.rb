class ParkingsController < ApplicationController

  before_action :authenticate_user!, except: [:parking_info, :photo_update]
  
  def index
    @parkings = Parking.all

    
    
    #render json: @parkings
  end

  def show
    @parking = Parking.find(params[:id])
    
  end

  def new

  end

  def edit
    @parking = Parking.find(params[:id])

  end

  def update
    @parking = Parking.find(params[:id])
    # check if the user updated the number of columns and rows for the parkings, if so
    # modify the existing ones.
    old_rows = @parking.rows
    old_columns = @parking.columns
    
    puts "Old stuff is #{@parking.rows}"
    
    if @parking.update_attributes(parking_params)
      if @parking.rows != old_rows || @parking.columns != old_columns
        # Magic goes here. To make things easy delete all the parking spots and create a new ones.
        @parking.slots.each do |slot|
          slot.delete
        end
        rows = @parking.rows
        columns = @parking.columns
        for i in 0..rows-1
          for j in 0..columns-1
            new_slot = Slot.new
            new_slot.name = "parking slot"
            new_slot.x_loc = j
            new_slot.y_loc = i
            new_slot.parking = @parking
            new_slot.state = "E"

            @parking.slot_ids << new_slot.id
            new_slot.save
          end
        end
        @parking.save

      end

      
      redirect_to '/parkings', :notice => "El parqueadero se actualizo correctamente"
    else
      render 'edit'
    end
  end

  def destroy
    @parking = Parking.find(params[:id])
    @parking.destroy
    redirect_to '/parkings', :notice => "Parking was deleted"
  end

  def create
    @parking = Parking.new(parking_params)
    @parking.save
    rows = @parking.rows
    columns = @parking.columns
    for i in 0..rows-1
      for j in 0..columns-1
      new_slot = Slot.new
      new_slot.name = "parking slot"
      new_slot.x_loc = j
      new_slot.y_loc = i
      new_slot.parking = @parking
      new_slot.state = "E"

      @parking.slot_ids << new_slot.id
      new_slot.save
      end
    end
    @parking.save
    
    redirect_to @parking
  end

  def parking_info
    #@parking = Parking.find(params[:id])
    #@parking = ["hello", "there"] We can use a dummy json here while the full functionality is implemented.
    parking = Parking.last
    slots = []
    parking.slots.each do |slot|
      tmp_val = {
        "x":slot.x_loc,
        "y":slot.y_loc,
        "estado":slot.state,
        "direccion":"U"
      }
      slots << tmp_val
    end
    
    final = {
      "parqueaderos": slots
    }
    
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

    #render json: park
    render json: final
    #render json: @parking
  end

  def photo_update
    #temp_file = params[:parking_spot].read
    #filename = params[:parking_spot].original_filename

    #File.open(Rails.root.join('lib', 'assets', 'python', filename), 'wb') do |file|
    #  file.write(temp_file)
    #end
    #puts filename


    #tmp_file = "#{Rails.root}/tmp/uploaded.jpg"
    #contents = params[:parking_spot].read
    data = `python lib/assets/python/parkit_script.py --image lib/assets/python/parking-6.jpg`
    arr = data[1..-2].split(',').collect! {|n| n.to_i}
    p_data = arr.in_groups(2)
    bla = {:holi => data}

    # Now update the parking slots according to the parsed states:
    parking = Parking.last
    if parking
      p_data.each_with_index do |spot, row|
        spot.each_with_index do |val, column|
          tmp_park = parking.slots.where(x_loc: column, y_loc: row).last
          if tmp_park
            if val == 0
              tmp_park.state = "E"
            elsif val == 1 || val == 2
              tmp_park.state = "F"
            end
            tmp_park.save

            puts tmp_park.state
          else
            puts "Got a problem here boss"
          end
          #puts "value is: #{val} at: #{row},#{column}"
        end
      end
    end
    render json: bla

  end

  private
  def parking_params
    params.require(:parking).permit(:name, :description, :rows, :columns)
  end
  
end
