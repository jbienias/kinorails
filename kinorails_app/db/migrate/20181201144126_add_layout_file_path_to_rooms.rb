class AddLayoutFilePathToRooms < ActiveRecord::Migration[5.2]
  def change
    add_column :rooms, :layout_file_path, :string
  end
end
