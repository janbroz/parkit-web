class Drone
  include Mongoid::Document

  field :name, type: String
  field :description, type: String

  belongs_to :parking
  
end
