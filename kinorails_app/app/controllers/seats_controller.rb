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
    if @seat.save
      redirect_to @seat, notice: 'Seat was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @seat.destroy
    redirect_to seats_url, notice: 'Seat was successfully destroyed.'
  end

  private
    def set_seat
      @seat = Seat.find(params[:id])
    end

    def seat_params
      params.require(:seat).permit(:room_id, :pos_x, :pos_y)
    end
end
