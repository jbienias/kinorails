class Screening < ApplicationRecord
  belongs_to :movie
  belongs_to :room
  has_many :reservations

  validates :movie_id, \
  numericality: { greater_than_or_equal_to: 0 }

  validates :room_id, \
  numericality: { greater_than_or_equal_to: 0 }

  validate :date_cannot_be_in_the_past

  # ewentualne poprawki konieczne
  def date_cannot_be_in_the_past
    if date.present? && date < Time.now # Date.today
      errors.add(:date, "nie może być w przeszłości!")
    end
  end

end
