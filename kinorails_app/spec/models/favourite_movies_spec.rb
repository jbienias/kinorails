require 'rails_helper'

RSpec.describe FavouriteMovie, type: :model do
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

  it 'is valid when user and movie exists' do
    expect(create_favourite_movie).to be_valid
  end
end

def create_favourite_movie(id: 0, movie_id: @movie.id, 
  user_id: @user.id)
  favourite_movie = FavouriteMovie.new
  favourite_movie.id = id
  favourite_movie.movie_id = movie_id
  favourite_movie.user_id = user_id
  favourite_movie
end
