class SlotsController < ApplicationController

  def change
    slot = Slot.find(params[:id])
    @parking = slot.parking
    if slot
      if slot.state == "E"
        slot.state = "F"
        slot.save
      elsif slot.state == "F"
        slot.state = "S"
        slot.save
      else
        slot.state = "E"
        slot.save
      end
    end
    
    puts "Hi, i want to change"
    redirect_to edit_parking_path(@parking.id)
    #head :ok, content_type: "text/html"
  end


  
end
