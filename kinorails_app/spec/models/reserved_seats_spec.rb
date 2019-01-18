require 'rails_helper'

RSpec.describe ReservedSeat, type: :model do
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
      role: 0
    })

    @reservation = Reservation.create!({
      id:0,
      user_id: @user.id,
      screening_id: @screening.id
    })

    @seat = Seat.create!({
      id: 0,
      pos_x: 0,
      pos_y: 0,
      room_id: @room.id
    })
  end

  it 'is valid when valid attributes' do
    expect(create_reserved_seat).to be_valid
  end
end

def create_reserved_seat(id: 0, seat_id: @seat.id, reservation_id: @reservation.id)
  rs = ReservedSeat.new
  rs.id = id
  rs.seat_id = seat_id
  rs.reservation_id = reservation_id
  rs
end
