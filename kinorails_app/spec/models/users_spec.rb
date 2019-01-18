require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid when unique and valid attributes' do
    expect(create_user).to be_valid
  end

  it 'is invalid when nickname is not unique' do
    User.create!({id: 0, email: 'random@onet.pl', username: 'KARAMCIC',
      name: 'Andrzej', surname: 'Karamzyt', password: 'andrzej123', phone_number: '24 123 456 789', role: 0})
    expect(create_user(username: 'KARAMCIC')).not_to be_valid
  end

  it 'is invalid when phone number is not unique' do
    User.create!({id: 0, email: 'random@onet.pl', username: 'KARAMCIC',
      name: 'Andrzej', surname: 'Karamzyt', password: 'andrzej123', phone_number: '58 123 456 789', role: 0})
    expect(create_user(phone_number: '58 123 456 789')).not_to be_valid
  end
end

def create_user(id: 0, email: 'akaramyt@onet.pl', username: 'akaramzyt',
  name: 'Andrzej', surname: 'Karamzyt', password: 'andrzej123', phone_number: '58 123 456 789', role: 0)
  user = User.new
  user.id = id
  user.email = email
  user.username = username
  user.name = name
  user.surname = surname
  user.phone_number = phone_number
  user.password = password
  user
end
