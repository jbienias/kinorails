class MoviesController < ApplicationController
  before_action :check_if_user_admin, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_movie, only: [:show, :edit, :update, :destroy]

  def index
    @movies = Movie.all
  end

  def show
    @screenings = Screening.all.where(:movie_id => @movie.id).where("date > ?", Time.now - 1.day)
  end

  def new
    @movie = Movie.new
  end

  def edit
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to @movie, notice: 'Movie was successfully created.'
    else
      render :new
    end
  end

  def update
    if @movie.update(movie_params)
      redirect_to @movie, notice: 'Movie was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    Screening.where(:movie_id => @movie.id).destroy_all
    FavouriteMovie.where(:movie_id => @movie.id).destroy_all
    @movie.destroy
    redirect_to movies_url, notice: 'Movie was successfully destroyed.'
  end

  private

    def check_if_user_admin
      @testadmin = (!current_user.nil? && current_user.admin?)

      if @testadmin == false
        redirect_to root_path, :notice => 'This action is only for admin.'
      end
    end

    def set_movie
      @movie = Movie.find(params[:id])
    end

    def movie_params
      params.require(:movie).permit(:title, :director, :country_of_origin, :length, :poster_link, :description)
    end
end
