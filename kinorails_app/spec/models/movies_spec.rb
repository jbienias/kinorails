require 'rails_helper'

RSpec.describe Movie, type: :model do
  it 'is valid when valid attributes' do
    expect(create_movie).to be_valid
  end

  it 'is invalid when title is empty' do
    expect(create_movie(title: '')).not_to be_valid
  end

  it 'is invalid when director is empty' do
    expect(create_movie(director: nil)).not_to be_valid
  end

  it 'is invalid when country of origin is empty' do
    expect(create_movie(country_of_origin: nil)).not_to be_valid
  end
end

def create_movie(title: 'Gothic 9 : Dzieje Khorinis',
                description: 'Był tu scenarzysta Kantar, podobno ukradłeś wszystkie rekwizyty.',
                poster_link: 'imgur.com/empty.png',
                length: 200,
                country_of_origin: 'Górnicza dolina®',
                director: 'Bezimienny')
  movie = Movie.new
  movie.title = title
  movie.description = description
  movie.poster_link = poster_link
  movie.length = length
  movie.country_of_origin = country_of_origin
  movie.director = director
  movie
end
