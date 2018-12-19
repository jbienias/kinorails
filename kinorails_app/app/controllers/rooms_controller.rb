class RoomsController < ApplicationController
  #before_action :authenticate_user!
  before_action :set_room, only: [:show, :edit, :update, :destroy]

  def index
    @rooms = Room.all
  end

  def show
    @seats = (Seat.all.where(:room_id => @room.id)).to_a
    @plan = convert_to_a
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

  def new
    @room = Room.new
  end

  def edit
  end

  def create
    @room = Room.new(room_params_create)

    err_count = 0
    seats_created = 0
    arr = load_seats_location(@room.layout_file_path)
    seat_arr = []

    arr.each_with_index do |row, i|
      row.each_with_index do |column, j|

        type_of_seat_tmp = change_type_of_seat(arr[i][j])

        if type_of_seat_tmp != -1
          @seat = create_seat(j, i, type_of_seat_tmp)
          seat_arr << @seat
        else
          err_count += 1
        end

      end
    end

    if err_count == 0
      if @room.save
        seat_arr.each do |s|
          assign_room_id_to_seat(s, @room.id)
          if s.save
            seats_created += 1
          else
            err_count += 1
          end
        end

        redirect_to @room, notice: "Room and #{seats_created} seats were successfully created."
      else
        Seat.where(:room_id => @room.id).destroy_all
        @room.destroy
        render :new, notice: "Room could not be saved!"
      end
    else
      render :new, notice: 'Room could not be saved. Make sure that file is correct!'
    end
  end

  def update
    if @room.update(room_params_update)
      redirect_to @room, notice: 'Room was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    Seat.where(:room_id => @room.id).destroy_all
    Screening.where(:room_id => @room.id).destroy_all
    @room.destroy
    redirect_to rooms_url, notice: 'Room was successfully destroyed.'
  end

  private
    def load_seats_location(filename)
      result = []
      File.open(filename).each_line { |i|
        result << i.chomp.split(" ")
      }
      result
    end

#    def convert_to_i(str)
#      Integer(str) rescue 0
#    end

    def create_seat(pos_x, pos_y, type)
      seat = Seat.new
      seat.pos_x = pos_x
      seat.pos_y = pos_y
      seat.type_of_seat = type
      seat
    end

    def assign_room_id_to_seat(seat, room_id)
      seat.room_id = room_id
    end

    def change_type_of_seat(type)
      if type == "0" || type == "1"
        type = type.to_i
        type
      else
        -1 # raiseError
      end
    end

    def set_room
      @room = Room.find(params[:id])
    end

    def room_params_create
      params.require(:room).permit(:name, :layout_file_path)
    end

    def room_params_update
      params.require(:room).permit(:name)
    end
end
