class FavouriteMoviesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_if_user_not_admin
  before_action :set_favourite_movie, only: [:destroy]

  def index
    if current_user.admin?
      @favourite_movies = FavouriteMovie.all
    else
      @favourite_movies = FavouriteMovie.all.where(:user_id => current_user.id)
    end
  end

  def update
    @movie = Movie.find(params[:current_movie_id])
    @favourite_movie = FavouriteMovie.new
    @already = FavouriteMovie.all.where(:movie_id => @movie.id, :user_id => current_user.id)
    if @already.nil?
      @favourite_movie.movie_id = @movie.id
      @favourite_movie.user_id = current_user.id
      if @favourite_movie.save
        redirect_to favourite_movies_url, notice: 'Favourite movie was successfully created.'
      else
        redirect_to movies_url, notice: "Favourite movie wasn't created."
      end
    else
      redirect_to movies_url, notice: "Favourite movie is already present!"
    end
  end

  def favourite
    #nie usuwac xD
  end

  def destroy
    @favourite_movie.destroy
    redirect_to favourite_movies_url, notice: 'Favourite movie was successfully destroyed.'
  end

  private

    def check_if_user_not_admin
      @testuser = (!current_user.nil? && !current_user.admin?)

      if @testuser == false
        redirect_to root_path, :notice => 'This action is only for user.'
      end
    end

    def set_favourite_movie
      @favourite_movie = FavouriteMovie.find(params[:id])
    end
end
