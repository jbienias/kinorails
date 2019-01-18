class Seat < ApplicationRecord
  belongs_to :room
  has_many :reserved_seats

  validates :pos_x, \
  numericality: { greater_than_or_equal_to: 0 }

  validates :pos_y, \
  numericality: { greater_than_or_equal_to: 0 }
end
