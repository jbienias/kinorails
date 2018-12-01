class SeatsController < ApplicationController
  before_action :set_seat, only: [:show, :destroy]

  def index
    @seats = Seat.all
  end

  def show
  end

  def new
    @seat = Seat.new
    @rooms = Room.all.order(:name)
  end

  def create
    @seat = Seat.new(seat_params)
    @rooms = Room.all.order(:name)

    respond_to do |format|
      if @seat.save
        format.html { redirect_to @seat, notice: 'Seat was successfully created.' }
        format.json { render :show, status: :created, location: @seat }
      else
        format.html { render :new }
        format.json { render json: @seat.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @seat.destroy
    respond_to do |format|
      format.html { redirect_to seats_url, notice: 'Seat was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_seat
      @seat = Seat.find(params[:id])
    end

    def seat_params
      params.require(:seat).permit(:room_id, :pos_x, :pos_y)
    end
end
