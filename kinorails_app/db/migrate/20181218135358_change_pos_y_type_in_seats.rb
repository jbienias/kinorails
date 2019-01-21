class ChangePosYTypeInSeats < ActiveRecord::Migration[5.2]
  def change
    change_column :seats, :pos_y, :integer
  end
end
