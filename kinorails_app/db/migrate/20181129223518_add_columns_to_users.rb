class AddColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :login, :string, default: '', unique: true, null: false
    add_column :users, :name, :string, default: '', null: false
    add_column :users, :surname, :string, default: '', null: false
    add_column :users, :phone_number, :string, default: '', unique: true, null: false    
  end
end
