require 'rails_helper'

RSpec.describe ScreeningsController, type: :controller do
  before do
    @movie = Movie.create!({
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

    @user_admin = User.create!({
      email: 'test@test.test',
      password: 'testtest',
      username: 'test',
      name: 'test',
      surname: 'test',
      phone_number: '111 111 111',
      role: 1})
  end

  describe 'GET #index' do
    it 'assigns @screenings' do
      sign_in @user_admin
      get :index
      expect(assigns(:screenings)).to eq([@screening])
    end

    it 'renders the #index template' do
      sign_in @user_admin
      get :index
      expect(response).to render_template('index')
    end
  end

  describe 'GET #new' do
    it 'renders the #new view' do
      sign_in @user_admin
      get :new
      expect(response).to render_template('new')
    end
  end

  describe 'GET #show' do
    it 'renders the #show view' do
      sign_in @user_admin
      get :show, params: { id: @screening.id }
      expect(response).to render_template :show
    end
  end

  describe 'GET #edit' do
    it 'renders the #edit view' do
      sign_in @user_admin
      get :edit, params: { id: @screening.id }
      expect(response).to render_template :edit
    end
  end

  describe 'PATCH #update' do
    it 'updates the screening and redirects' do
      put :update, params: { id: @screening.id, screening: { :date => Time.now + 10.days} }
      expect(response).to be_redirect
    end
  end

  describe 'PUT #destroy' do
    it 'destroys screening when admin' do
      sign_in @user_admin
      expect { 
        delete :destroy, params: { id: @screening.id}
      }.to change(Screening, :count).by(-1)
    end

    it 'does not destroy screening when not admin' do
      expect {
        delete :destroy, params: { id: @movie.id}
      }.to change(Movie, :count).by(0)
    end
  end
end
