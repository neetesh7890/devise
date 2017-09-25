class AddLatLngToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :lat, :decimal
    add_column :users, :lng, :decimal
    add_column :users, :cmp_name, :string
  end
end
