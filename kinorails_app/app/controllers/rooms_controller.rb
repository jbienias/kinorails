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
    if @room.save
      err_count = 0
      seats_created = 0
      arr = load_seats_location(@room.layout_file_path)

      arr.each_with_index do |row, i|
        row.each_with_index do |column, j|
          @seat = create_seat(@room.id, i, j, convert_to_i(column))
          tmp = @seat.save
          if !tmp
            err_count += 1
          else
            seats_created += 1
          end
        end
      end

      if err_count == 0
        redirect_to @room, notice: "Room and #{seats_created} seats were successfully created."
      end
    else
      render :new
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

    def convert_to_i(str)
      Integer(str) rescue 0
    end

    def create_seat(room_id, pos_x, pos_y, type)
      seat = Seat.new
      seat.pos_x = pos_x
      seat.pos_y = pos_y
      seat.room_id = room_id
      if type.between?(0,1)
        seat.type_of_seat = type
      else
        seat.type_of_seat = 0
      end
      seat
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
