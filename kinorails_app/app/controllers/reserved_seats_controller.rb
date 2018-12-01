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

    respond_to do |format|
      if @reserved_seat.save
        format.html { redirect_to @reserved_seat, notice: 'Reserved seat was successfully created.' }
        format.json { render :show, status: :created, location: @reserved_seat }
      else
        format.html { render :new }
        format.json { render json: @reserved_seat.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @reserved_seat.destroy
    respond_to do |format|
      format.html { redirect_to reserved_seats_url, notice: 'Reserved seat was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_reserved_seat
      @reserved_seat = ReservedSeat.find(params[:id])
    end

    def reserved_seat_params
      params.require(:reserved_seat).permit(:reservation_id, :seat_id)
    end
end
