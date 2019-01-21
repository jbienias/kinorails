class AddTypeToSeats < ActiveRecord::Migration[5.2]
  def change
    add_column :seats, :type, :integer
  end
end
