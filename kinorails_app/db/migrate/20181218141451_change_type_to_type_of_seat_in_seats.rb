class ChangeTypeToTypeOfSeatInSeats < ActiveRecord::Migration[5.2]
  def change
    remove_column :seats, :type
    add_column :seats, :type_of_seat, :integer
  end
end
