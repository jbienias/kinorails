require 'rails_helper'

RSpec.describe Movie, type: :model do

  it "is valid with valid attributes" do
    movie = create_movie
    expect(movie).to be_valid
  end

  it "it is invalid when title is empty" do
    movie = create_movie(title = "")
    expect(movie).not_to be_valid
  end

  it "it is invalid when director is empty" do

  end
end

def create_movie(title = "Gothic 9 : Dzieje Khorinis",
                description = "Był tu scenarzysta Kantar, podobno ukradłeś wszystkie rekwizyty.",
                poster_link = "imgur.com/empty.png",
                length = 200,
                country_of_origin = "Górnicza dolina®",
                director = "Bezimienny")
  movie = Movie.new
  movie.title = title
  movie.description = description
  movie.poster_link = poster_link
  movie.length = length
  movie.country_of_origin = country_of_origin
  movie.director = director
  movie
end