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

    respond_to do |format|
      if @room.save
        format.html { redirect_to @room, notice: 'Room was successfully created.' }
        format.json { render :show, status: :created, location: @room }
      else
        format.html { render :new }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @room.update(room_params_update)
        format.html { redirect_to @room, notice: 'Room was successfully updated.' }
        format.json { render :show, status: :ok, location: @room }
      else
        format.html { render :edit }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    #Remember to add cascade delete to seats, etc.
    #Example: Seat.where(:room_id => @room.id).destroy_all
    @room.destroy
    respond_to do |format|
      format.html { redirect_to rooms_url, notice: 'Room was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
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
