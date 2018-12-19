class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :destroy]

  def index
    @reservations = Reservation.all
  end

  def show
  end

  def new
    @reservation = Reservation.new
    @screening = Screening.find(params[:current_screening_id])
    @seats = (Seat.all.where(:room_id => @screening.room_id)).to_a
    @plan = convert_to_a

    @reserved_seats = []

    @seats.each do |s|
      res_tmp = ReservedSeat.where(:seat_id => s.id).first # ew. find
      if res_tmp
        @reserved_seats << res_tmp
      end
    end
  end

  def convert_to_a
    max_x = @seats[-1].pos_x
    max_y = @seats.max_by(&:pos_y).pos_y

    @plan = Array.new(max_y + 1) { Array.new(max_x + 1) }

    @seats.each do |s|
      @plan[s.pos_y][s.pos_x] = s.type_of_seat # =
    end

    @plan.length.times do |i|
      @plan[i] = @plan[i].map {|e| e.nil? ? 0 : e}
    end

    @plan
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
