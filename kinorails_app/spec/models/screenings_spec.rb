require 'rails_helper'

RSpec.describe Screening, type: :model do
  before do
    @movie = Movie.create!({
      id: 0,
      title: 'Test title',
      director: 'Test director',
      country_of_origin: 'Poland',
      length: 200,
      poster_link: nil,
      description: nil,
    })

    @room = Room.create!({
      id: 0,
      name: 'Karkand',
      layout_file_path: '/home/tmp.txt',
    })
  end

  it 'is valid when valid attributes' do
    expect(create_screening).to be_valid
  end

  it 'wont be valid when room has a screening at the same time' do
    Screening.create!({id: 1, movie_id: 0, room_id: 0, date: Time.now + 7.days})
    expect(create_screening).not_to be_valid
  end

  it 'wont be valid when date in past / today' do
    expect(create_screening(date: Time.now)).not_to be_valid
  end
end

def create_screening(id: 0, movie_id: @movie.id, room_id: @room.id,
  date: Time.now + 7.days)
  screening = Screening.new
  screening.id = id
  screening.movie_id = movie_id
  screening.room_id = room_id
  screening.date = date
  screening
end
