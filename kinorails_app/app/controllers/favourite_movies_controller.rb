class FavouriteMoviesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_if_user_not_admin
  before_action :set_favourite_movie, only: [:destroy]

  helper_method :sort_column, :sort_direction

  def index
    if current_user.admin?
      if params[:search]
        @favourite_movies = FavouriteMovie.search(params[:search]).order("movie_id DESC")
      else
        @favourite_movies = FavouriteMovie.all.order("#{sort_column} #{sort_direction}")
      end
    else
      if params[:search]
        @favourite_movies = FavouriteMovie.search(params[:search]).order("movie_id DESC")
      else
        @favourite_movies = FavouriteMovie.all.where(:user_id => current_user.id).order("#{sort_column} #{sort_direction}")
      end
    end
  end

  def update
    @movie = Movie.find(params[:current_movie_id])
    @favourite_movie = FavouriteMovie.new
    @already = FavouriteMovie.all.where(:movie_id => @movie.id, :user_id => current_user.id)
    if @already.empty? #refactored @already.nil?
      @favourite_movie.movie_id = @movie.id
      @favourite_movie.user_id = current_user.id
      if @favourite_movie.save
        redirect_to movies_url, notice: 'Favourite movie was successfully added.'
      else
        redirect_to movies_url, notice: "Favourite movie wasn't created."
      end
    else
      @already.destroy_all
      redirect_to movies_url, notice: "Favourite movie was successfully deleted."
    end
  end

  def favourite
    #nie usuwac xD
  end

  def destroy
    @favourite_movie.destroy
    redirect_to favourite_movies_url, notice: 'Favourite movie was successfully deleted.'
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

    # sorting 
    def sortable_columns
      ["id"]
    end
  
    def sort_column
      sortable_columns.include?(params[:column]) ? params[:column] : "id"
    end
  
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
