class Movie < ApplicationRecord
  has_many :favourite_movies
  has_many :screenings
end
