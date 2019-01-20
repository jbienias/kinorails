class RoomsController < ApplicationController
  #before_action :authenticate_user!
  before_action :check_if_user_admin
  before_action :set_room, only: [:show, :edit, :update, :destroy]

  helper_method :sort_column, :sort_direction

  def index
    if params[:search]
      @rooms = Room.search(params[:search]).order("name DESC")
    else
      @rooms = Room.all.order("#{sort_column} #{sort_direction}")
    end
  end

  def show
    @seats = Seat.all.where(:room_id => @room.id).to_a
    @plan = seats_to_plan(@seats)
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
    if @room.layout_file_path.to_s.empty? || !File.file?(@room.layout_file_path)
      flash.now[:notice] = 'Room could not be saved. Make sure that the file you provided exists!'
      render :new
    else
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
              if s.type_of_seat == 1
                seats_created += 1
              end
            else
              err_count += 1
            end
          end
          redirect_to @room, notice: "Room and #{seats_created} seats were successfully created."
        else
          Seat.where(:room_id => @room.id).destroy_all
          @room.destroy
          flash[:notice] = "Room could not be saved!"
          render :new
        end
      else
        flash.now[:notice] = 'Room could not be saved. Make sure that the file you provided is correct!'
        render :new
      end
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

    def check_if_user_admin
      @testadmin = (!current_user.nil? && current_user.admin?)

      if @testadmin == false
        redirect_to root_path, :notice => 'This action is only for admin.'
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

    def load_seats_location(filename)
      result = []
      File.open(filename).each_line { |i|
        result << i.chomp.split(" ")
      }
      result
    end

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
        -1
      end
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

    # sorting 
    def sortable_columns
      ["name"]
    end
  
    def sort_column
      sortable_columns.include?(params[:column]) ? params[:column] : "name"
    end
  
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
