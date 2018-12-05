class Reservation < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :screening
  has_many :reserved_seats

  validates_uniqueness_of :identifier

  validates :identifier, \
  numericality: { greater_than_or_equal_to: 0 }
end
