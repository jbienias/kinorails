class Screening < ApplicationRecord
  belongs_to :movie
  belongs_to :room
  has_many :reservations

  validate :check_room_availability
  validate :date_of_screening_in_past?

  def check_room_availability
    movie_start = self.date
    all_room_screenings = Screening.all.where(:room_id => self.room_id)
    all_room_screenings.each do |s|
      s_movie_start = s.date
      s_movie_end = s_movie_start + s.movie.length*60 + 29*60 #29 -> we can create new screening in the same room after 30 (29 + 1) mins between screenings
      if (movie_start.between?(s_movie_start, s_movie_end))
        errors.add("Room #{self.room.name}", " has a screening in given time!")
        break
      end
    end
  end

  def date_of_screening_in_past?
    if self.date < Date.tomorrow
      errors.add("Screening date", "cannot be for today or past date!")
    end
  end
end
