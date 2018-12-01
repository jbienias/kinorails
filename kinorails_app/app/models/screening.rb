class Screening < ApplicationRecord
  belongs_to :movie
  belongs_to :room
  has_many :reservations
end
