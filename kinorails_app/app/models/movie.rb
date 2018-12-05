class Movie < ApplicationRecord
  has_many :favourite_movies
  has_many :screenings

  validates :title, \
  :length => { :in => 1..30 }

  validates :director, \
  :length => { :in => 1..30 }

  validates :country_of_origin, \
  :length => { :in => 1..30 }

  validates :length, \
  numericality: { greater_than_or_equal_to: 0 }

  validates :poster_link, \
  allow_empty: false

  validates :description, \
  allow_empty: false
end
