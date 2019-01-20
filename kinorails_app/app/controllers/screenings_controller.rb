class ScreeningsController < ApplicationController
  #before_action :authenticate_user!
  before_action :check_if_user_admin, only: [:index, :new, :create, :edit, :update, :destroy]
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
    if @screening.date < Date.today
      redirect_to @screening, notice: 'You cannot edit past screening!'
    end
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
    reservations = Reservation.all.where(:screening_id => @screening.id)
    reservations.each do |r|
      ReservedSeat.all.where(:reservation_id => r.id).destroy_all
      r.destroy
    end
    @screening.destroy
    redirect_to screenings_url, notice: 'Screening was successfully destroyed.'
  end

  private

    def check_if_user_admin
      @testadmin = (!current_user.nil? && current_user.admin?)

      if @testadmin == false
        redirect_to root_path, :notice => 'This action is only for admin.'
      end
    end

    def set_screening
      @screening = Screening.find(params[:id])
    end

    def screening_params
      params.require(:screening).permit(:movie_id, :room_id, :date)
    end
end
