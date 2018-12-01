class CreateSeats < ActiveRecord::Migration[5.2]
  def change
    create_table :seats do |t|
      t.integer :room_id
      t.integer :pos_x
      t.string :pos_y

      t.timestamps
    end
  end
end
