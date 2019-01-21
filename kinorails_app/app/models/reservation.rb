class Reservation < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :screening
  has_many :reserved_seats

  before_create :assign_unique_case_number

  validates! :identifier, uniqueness: true

  private

  NUMBER_RANGE = (1_000_000..9_999_999)

  def assign_unique_case_number
    self.identifier = loop do
      number = rand(NUMBER_RANGE)
      break number unless Reservation.exists?(identifier: number)
    end
  end
end