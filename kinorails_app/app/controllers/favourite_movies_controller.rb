class FavouriteMoviesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_favourite_movie, only: [:show, :destroy]

  def index
    if current_user.admin?
      @favourite_movies = FavouriteMovie.all
    else
      @favourite_movies = FavouriteMovie.all.where(:user_id => current_user.id)
    end
  end

  def new
    @favourite_movie = FavouriteMovie.new
    @movie = Movie.find(params[:current_movie_id])
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
