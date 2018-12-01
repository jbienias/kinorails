class FavouriteMoviesController < ApplicationController
  #before_action :authenticate_user!
  before_action :set_favourite_movie, only: [:show, :edit, :update, :destroy]

  def index
    @favourite_movies = FavouriteMovie.all
  end

  def show
  end

  def new
    @favourite_movie = FavouriteMovie.new
  end

  def edit
  end

  def create
    @favourite_movie = FavouriteMovie.new(favourite_movie_params)

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

  def update
    respond_to do |format|
      if @favourite_movie.update(favourite_movie_params)
        format.html { redirect_to @favourite_movie, notice: 'Favourite movie was successfully updated.' }
        format.json { render :show, status: :ok, location: @favourite_movie }
      else
        format.html { render :edit }
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
      params.require(:favourite_movie).permit(:user_id, :movie_id)
    end
end
