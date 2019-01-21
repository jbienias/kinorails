require 'rails_helper'

RSpec.describe Room, type: :model do
  it 'is valid when valid attributes' do
    expect(create_room).to be_valid
  end

  it 'is invalid when name is empty' do
    expect(create_room(name: nil)).not_to be_valid
  end
end

def create_room(id: 0, name: 'Karkand', layout_file_path: '/home/tmp.txt')
 room = Room.new
 room.id = id
 room.name = name
 room.layout_file_path = layout_file_path
 room
end
