class Slot
  include Mongoid::Document

  field :name, type: String
  field :x_loc, type: Integer
  field :y_loc, type: Integer
  field :state, type: String
  field :direction, type: String

  belongs_to :parking
  
  validates :x_loc, :y_loc, presence: true
  
end
