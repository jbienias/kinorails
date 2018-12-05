class Room < ApplicationRecord
  has_many :seats

  validates_uniqueness_of :name

  validates :name, \
  :length => { :in => 1..50 }, \
  allow_blank: false, \
  allow_empty: false
end
