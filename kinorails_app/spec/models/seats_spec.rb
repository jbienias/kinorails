require 'rails_helper'

RSpec.describe Seat, type: :model do
  before do
    @room = Room.create!({
      id: 0,
      name: 'Karkand',
      layout_file_path: '/home/tmp.txt',
    })  
  end

  it 'is valid when valid attributes' do
    expect(create_seat).to be_valid
  end

  it 'is invalid when pos_x is less then 0' do
    expect(create_seat(pos_x: -1)).not_to be_valid
  end

  it 'is invalid when pos_y is less then 0' do
    expect(create_seat(pos_y: -1)).not_to be_valid
  end
end

def create_seat(id: 0, room_id: @room.id, pos_x: 0, pos_y: 0)
  seat = Seat.new
  seat.id = id
  seat.room_id = @room.id
  seat.pos_x = pos_x
  seat.pos_y = pos_y
  seat
end
