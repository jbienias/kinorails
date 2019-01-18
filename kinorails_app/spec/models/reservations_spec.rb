require 'rails_helper'

RSpec.describe Reservation, type: :model do
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

    @screening = Screening.create!({
      id: 0, 
      movie_id: @movie.id,
      room_id: @room.id,
      date: Time.now + 7.days
    })

    @user = User.create!({
      id: 0,
      email: 'test@test.test',
      password: 'testtest',
      username: 'test',
      name: 'test',
      surname: 'test',
      phone_number: '111 111 111',
      role: 0})
  end

  it 'is valid when valid attributes' do
    expect(create_reservation).to be_valid
  end

  it 'generates unique reservation identifier' do
    @reservation = Reservation.create!({id:0, user_id: @user.id, screening_id: @screening.id})
    expect(@reservation.identifier).to be_a(String)
  end
end

def create_reservation(id:0, user_id: @user.id, screening_id: @screening.id)
  reservation = Reservation.new
  reservation.id = id
  reservation.user_id = user_id
  reservation.screening_id = screening_id
  reservation
end

