class ScreeningsController < ApplicationController
  #before_action :authenticate_user!
  before_action :set_screening, only: [:show, :edit, :update, :destroy]

  def index
    @screenings = Screening.all
  end

  def show
  end

  def new
    @screening = Screening.new
    @movies = Movie.all.order(:title)
    @rooms = Room.all.order(:name)
  end

  def edit
    @movies = Movie.all.order(:title)
    @rooms = Room.all.order(:name)
  end

  def create
    @screening = Screening.new(screening_params)
    @movies = Movie.all.order(:title)
    @rooms = Room.all.order(:name)
    if @screening.save
      redirect_to @screening, notice: 'Screening was successfully created.'
    else
      render :new
    end
  end

  def update
    if @screening.update(screening_params)
      redirect_to @screening, notice: 'Screening was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    Reservation.where(:screening_id => @screening.id).destroy_all
    @screening.destroy
    redirect_to screenings_url, notice: 'Screening was successfully destroyed.'
  end

  private

    def set_screening
      @screening = Screening.find(params[:id])
    end

    def screening_params
      params.require(:screening).permit(:movie_id, :room_id, :date)
    end
end
