class Parking
  include Mongoid::Document

  field :name, type: String
  field :description, type: String

  field :rows, type: Integer
  field :columns, type: Integer

  has_and_belongs_to_many :slots
  has_one :drone
  
  validates :name, presence: true
  
end
