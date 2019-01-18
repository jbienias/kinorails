require 'rails_helper'

RSpec.describe FavouriteMoviesController, type: :controller do
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
    
    @movie_2 = Movie.create!({
      id: 1,
      title: 'Test title 2',
      director: 'Test director 2',
      country_of_origin: 'Deutschland',
      length: 222,
      poster_link: nil,
      description: nil,
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

    @favourite_movie = FavouriteMovie.create!({
      id: 0,
      movie_id: @movie.id,
      user_id: @user.id
    })
  end

  describe 'GET #index' do
    it 'assigns @favourite_movies' do
      sign_in @user
      get :index
      expect(assigns(:favourite_movies)).to eq([@favourite_movie])
    end

    it 'renders the #index template' do
      sign_in @user
      get :index
      expect(response).to render_template('index')
    end
  end

  describe 'PATCH #update' do
    it 'updates the favourite movie and redirects' do
      put :update, params: { id: @favourite_movie.id, favourite_movie: { :movie_id => 1} }
      expect(response).to be_redirect
    end
  end

  describe 'PUT #destroy' do
    it 'destroys favourite movie when logged in' do
      sign_in @user
      expect { 
        delete :destroy, params: { id: @favourite_movie.id} 
      }.to change(FavouriteMovie, :count).by(-1)
    end

    it 'does not destroy favourite movie when not logged in' do
      expect {
        delete :destroy, params: { id: @favourite_movie.id}
      }.to change(FavouriteMovie, :count).by(0)
    end
  end
end
