class ReservedSeat < ApplicationRecord
  belongs_to :reservation
  belongs_to :seat

  validates_uniqueness_of :reservation_id

  validates :reservation_id, \
  numericality: { greater_than_or_equal_to: 0 }
end
