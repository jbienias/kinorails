class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :destroy]

  def index
    @reservations = Reservation.all
  end

  def show
  end

  def new
    @reservation = Reservation.new
    @screening = Screening.find(params[:screening_id])
  end

  def create
    @reservation = Reservation.new(reservation_params)
    if current_user != nil
      @reservation.user_id = current_user.id
    end
    if @reservation.save
      redirect_to @reservation, notice: 'Reservation was successfully created.'
    else
      render :new
    end
  end

  def destroy
    ReservedSeat.where(:reservation_id => @reservation.id).destroy_all
    @reservation.destroy
    redirect_to reservations_url, notice: 'Reservation was successfully destroyed.'
  end

  private
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    def reservation_params
      params.require(:reservation).permit(:screening_id)
    end
end
