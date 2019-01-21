require 'rails_helper'

RSpec.describe ReservationsController, type: :controller do
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

    @reservation = Reservation.create!({
      id: 0,
      user_id: @user.id,
      screening_id: @screening.id
    })
  end

  describe 'GET #index' do
    it 'assigns @reservation' do
      sign_in @user
      get :index
      expect(assigns(:reservations)).to eq([@reservation])
    end

    it 'renders the #index template' do
      sign_in @user
      get :index
      expect(response).to render_template('index')
    end
  end

  describe 'PUT #destroy' do
    it 'destroys reservation when logged in' do
      sign_in @user
      expect { 
        delete :destroy, params: { id: @reservation.id} 
      }.to change(Reservation, :count).by(-1)
    end

    it 'does not destroy movie when not logged in' do
      expect {
        delete :destroy, params: { id: @reservation.id}
      }.to change(Movie, :count).by(0)
    end
  end
end
