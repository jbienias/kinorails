class ReservationsController < ApplicationController
  #before_action :authenticate_user! <- i guess we don't need this here, because
  #both user and guest will be able to make a reservation
  before_action :set_reservation, only: [:show, :destroy]

  def index
    @reservations = Reservation.all
  end

  def show
  end

  def new
    @reservation = Reservation.new
    @screenings = Screening.all.order(:id)
  end

  def create
    @reservation = Reservation.new(reservation_params)
    #TMP :
    if current_user.id
      @reservation.user_id = current_user.id
    end
    #TODO
    #@reservation.identifier = generate()
    #if current_user #user logged in
      #@reservation.user_id = current_user.id
      #redirect user to his reservations and show the newest one
    #else #guest session
      #show the identifier to the guest (same page/different page, whatever :P)
    #end
    if @reservation.save
      redirect_to @reservation, notice: 'Reservation was successfully created.'
    else
      render :new
    end
  end

  def destroy
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
