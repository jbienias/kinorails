class FavouriteMoviesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_favourite_movie, only: [:show, :destroy]

  def index
    @favourite_movies = FavouriteMovie.all
  end

  def new
    @favourite_movie = FavouriteMovie.new
    @movies = Movie.all.order(:title)
  end

  def create
    @movies = Movie.all.order(:title)
    @favourite_movie = FavouriteMovie.new(favourite_movie_params)
    @favourite_movie.user_id = current_user.id
    if @favourite_movie.save
      redirect_to favourite_movies_url, notice: 'Favourite movie was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @favourite_movie.destroy
    redirect_to favourite_movies_url, notice: 'Favourite movie was successfully destroyed.'
  end

  private
    def set_favourite_movie
      @favourite_movie = FavouriteMovie.find(params[:id])
    end

    def favourite_movie_params
      params.require(:favourite_movie).permit(:movie_id)
    end
end
