class CreateReservedSeats < ActiveRecord::Migration[5.2]
  def change
    create_table :reserved_seats do |t|
      t.integer :reservation_id
      t.integer :seat_id

      t.timestamps
    end
  end
end
