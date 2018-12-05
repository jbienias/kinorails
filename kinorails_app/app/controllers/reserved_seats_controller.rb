class ReservedSeatsController < ApplicationController
  #before_action :authenticate_user!
  before_action :set_reserved_seat, only: [:show, :edit, :update, :destroy]

  def index
    @reserved_seats = ReservedSeat.all
  end

  def show
  end

  def new
    @reserved_seat = ReservedSeat.new
    @reservations = Reservation.all
    @seats = Seat.all
  end

  def edit
  end

  def create
    @reserved_seat = ReservedSeat.new(reserved_seat_params)
    if @reserved_seat.save
      redirect_to @reserved_seat, notice: 'Reserved seat was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @reserved_seat.destroy
    redirect_to reserved_seats_url, notice: 'Reserved seat was successfully destroyed.'
  end

  private
    def set_reserved_seat
      @reserved_seat = ReservedSeat.find(params[:id])
    end

    def reserved_seat_params
      params.require(:reserved_seat).permit(:reservation_id, :seat_id)
    end
end
