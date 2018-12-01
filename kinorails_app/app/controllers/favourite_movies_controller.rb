class FavouriteMoviesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_favourite_movie, only: [:show, :destroy]

  def index
    @favourite_movies = FavouriteMovie.all
  end

  def show
  end

  def new
    @favourite_movie = FavouriteMovie.new
    @movies = Movie.all.order(:title)
  end

  def create
    @movies = Movie.all.order(:title)
    @favourite_movie = FavouriteMovie.new(favourite_movie_params)
    @favourite_movie.user_id = current_user.id
    respond_to do |format|
      if @favourite_movie.save
        format.html { redirect_to @favourite_movie, notice: 'Favourite movie was successfully created.' }
        format.json { render :show, status: :created, location: @favourite_movie }
      else
        format.html { render :new }
        format.json { render json: @favourite_movie.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @favourite_movie.destroy
    respond_to do |format|
      format.html { redirect_to favourite_movies_url, notice: 'Favourite movie was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_favourite_movie
      @favourite_movie = FavouriteMovie.find(params[:id])
    end

    def favourite_movie_params
      params.require(:favourite_movie).permit(:movie_id)
    end
end
