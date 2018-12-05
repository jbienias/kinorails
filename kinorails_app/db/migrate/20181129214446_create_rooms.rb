class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|
      t.integer :seats
      t.string :plan

      t.timestamps
    end
  end
end
