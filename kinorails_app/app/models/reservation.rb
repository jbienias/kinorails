class Reservation < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :screening
  has_many :reserved_seats
end
