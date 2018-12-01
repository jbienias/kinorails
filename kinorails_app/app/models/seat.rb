class Seat < ApplicationRecord
  belongs_to :room
  has_many :reserved_seats
end
