class RoomsController < ApplicationController
  #before_action :authenticate_user!
  before_action :set_room, only: [:show, :edit, :update, :destroy]

  def index
    @rooms = Room.all
  end

  def show
  end

  def new
    @room = Room.new
  end

  def edit
  end

  def create
    @room = Room.new(room_params_create)

    #TODO
    #When the room is created, we have to also create it's seats
    #accordingly to existing file located in layout_file_path...

    if @room.save
      err_count = 0
      for i in 1...5
        for j in 'A'...'E'
          @seat = create_seat(@room.id, i, j)
          if @seat.save
            err_count += 1
          end
        end
      end
      if @seat.save
        redirect_to @room, notice: 'Room and Seat was successfully created.'
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
    @room.destroy
    redirect_to rooms_url, notice: 'Room was successfully destroyed.'
  end

  private
    def create_seat(room_id, pos_x, pos_y)
      seat = Seat.new
      seat.pos_x = pos_x
      seat.pos_y = pos_y
      seat.room_id = room_id
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
