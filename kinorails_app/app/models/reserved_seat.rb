class ReservedSeat < ApplicationRecord
  belongs_to :reservation
  belongs_to :seat

  before_create :get_all_reserved_seats_ids
  after_create :check_uniqueness_of_new_seats

  def get_all_reserved_seats_ids
    @reservations = Reservation.all.where(:screening_id => self.reservation.screening_id)
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
  end

  def check_uniqueness_of_new_seats
    @selected_seats= ReservedSeat.all.where(:reservation_id => self.reservation_id)
    @selected_seats_ids = []
    @selected_seats.each do |i|
      @selected_seats_ids << i.seat_id
    end

    if (@selected_seats_ids - @reserved_seats_ids).empty?
      #errors.add("...")
      raise ActiveRecord::Rollback
    end
  end
end
