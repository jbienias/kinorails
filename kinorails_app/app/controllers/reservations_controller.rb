class ReservationsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :edit, :update, :destroy]
  before_action :set_reservation, only: [:show, :destroy]

  def index
    @testadmin = (!current_user.nil? && current_user.admin?)

    if @testadmin
      @reservations = Reservation.all
    else
      @reservations = Reservation.all.where(:user_id => current_user.id)
    end
  end

  def show
    if current_user.nil? || @reservation.user_id != current_user.id
      redirect_to root_path
    end
    @seats = Seat.all.where(:room_id => @reservation.screening.room_id)
    @plan = seats_to_plan(@seats)
    @reserved_seats = ReservedSeat.all.where(:reservation_id => @reservation.id)
  end

  def new
    @reservation = Reservation.new
    @screening = Screening.find(params[:current_screening_id])
    if @screening.date < Date.today
      redirect_to screenings_url, notice: 'Cannot create reservation on past screening!'
    end
    @seats = Seat.all.where(:room_id => @screening.room_id).to_a
    @plan = seats_to_plan(@seats)

    @reserved_seats = []
    @seats.each do |s|
      result = ReservedSeat.where(:seat_id => s.id).first
      if result
        @reserved_seats << result
      end
    end
  end

  def create
    @screening = Screening.find(params[:screening_id])
    @seats = Seat.all.where(:room_id => @screening.room_id).to_a
    @plan = seats_to_plan(@seats)

    @reservations = Reservation.all.where(:screening_id => params[:screening_id].to_i)
    @reservations = @reservations.to_a
    @reserved_seats = []
    @reservations.each do |r|
      @reserved_seats << ReservedSeat.all.where(:reservation_id => r.id)
    end
    @reserved_seats = @reserved_seats.flatten
    @reserved_seats_ids = []
    @reserved_seats.each do |i|
      @reserved_seats_ids << i.seat_id
    end

    @reservation = Reservation.new(reservation_params)

    if params[:selected_seats].nil?
      flash[:notice] = "Nie wybrano żadnych miejsc. Spróbuj ponownie!"
      render :new
    end

    err_count = 0
    ss_count = 0
    if current_user != nil
      @reservation.user_id = current_user.id
    end

    if @reservation.save
      params[:selected_seats].each do |ss|
      @selected_seat = create_reserved_seat(@reservation.id, ss)
      if @selected_seat.save
         ss_count = ss_count + 1
       else
         err_count = err_count + 1
       end
    end

    if err_count > 0
      ReservedSeat.where(:reservation_id => @reservation.id).destroy_all
      @reservation.destroy
      flash[:notice] = "In the meantime somebody already booked some of your chosen seats (count: #{err_count}). Choose new seats to book!"
      render :new
    else
      redirect_to @reservation, notice: "Reservation was successfully created and you've booked #{ss_count} seats!"
    end
  end
end

  def destroy
    @testdestroy = ((!current_user.nil?) && ((current_user.admin?) || ReservedSeat.where(:user_id => current_user.id)))

    if @testdestroy
      ReservedSeat.where(:reservation_id => @reservation.id).destroy_all
      @reservation.destroy
      redirect_to reservations_url, notice: 'Reservation was successfully destroyed.'
    else
      redirect_to root_path, :notice => 'You can not destroy this reservation'
    end
  end

  private

    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    def reservation_params
      params.require(:reservation).permit(:screening_id)
    end

    def create_reserved_seat(reservation_id, seat_id)
      reserved_seat = ReservedSeat.new
      reserved_seat.reservation_id = reservation_id
      reserved_seat.seat_id = seat_id
      reserved_seat
    end

    def seats_to_plan(seats_array)
      max_x = seats_array[-1].pos_x
      max_y = seats_array.max_by(&:pos_y).pos_y

      plan = Array.new(max_y + 1) { Array.new(max_x + 1) }

      seats_array.each do |s|
        plan[s.pos_y][s.pos_x] = s.type_of_seat
      end

      plan.length.times do |i|
        plan[i] = plan[i].map {|e| e.nil? ? 0 : e}
      end

      plan
    end
end
