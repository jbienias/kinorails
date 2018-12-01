class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.integer :user_id
      t.integer :screening_id
      t.string :identifier

      t.timestamps
    end
  end
end
