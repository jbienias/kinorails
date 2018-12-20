class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :destroy]

  def index
    @reservations = Reservation.all
  end

  def show
    @reserved_seats = ReservedSeat.all.where(:reservation_id => @reservation.id)
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
    @screening = Screening.find(params[:screening_id])
    @seats = (Seat.all.where(:room_id => @screening.room_id)).to_a
    @plan = convert_to_a

    @reservations = Reservation.all.where(:screening_id => params[:screening_id].to_i)
    @reservations = @reservations.to_a
    @reserved_seats = []
    @reservations.each do |r|
      @reserved_seats << ReservedSeat.all.where(:reservation_id => r.id)
    end
    @reserved_seats = @reserved_seats.flatten #<- wszystkie (aktualne) zajete miejsca dla danego screeningu

    @reserved_seats_ids = []
    @reserved_seats.each do |i|
      @reserved_seats_ids << i.seat_id
    end

    @reservation = Reservation.new(reservation_params)

    if params[:selected_seats].nil?
      flash[:notice] = "Nie wybrano żadnych miejsc. Spróbuj ponownie!"
      render :new
    else
      err_count = 0
      params[:selected_seats].each do |ss|
        if @reserved_seats_ids.include? ss
          err_count = err_count + 1
        end
      end

      if err_count > 0
        flash[:notice] = "Nieznany błąd (#{err_count})!"
        render :new
      else 
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
            flash[:notice] = "Ktoś zajął Ci miejsca (ilość miejsc: #{err_count})!"
            render :new
          else
            redirect_to @reservation, notice: "Reservation was successfully created and you've booked #{ss_count} seats!"
          end
        else
          render :new
        end
      end
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

    def create_reserved_seat(reservation_id, seat_id)
      reserved_seat = ReservedSeat.new
      reserved_seat.reservation_id = reservation_id
      reserved_seat.seat_id = seat_id
      reserved_seat
    end
end
