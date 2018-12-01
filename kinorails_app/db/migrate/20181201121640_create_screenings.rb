class CreateScreenings < ActiveRecord::Migration[5.2]
  def change
    create_table :screenings do |t|
      t.integer :movie_id
      t.integer :room_id
      t.datetime :date

      t.timestamps
    end
  end
end
