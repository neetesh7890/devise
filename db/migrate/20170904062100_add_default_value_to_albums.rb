class AddDefaultValueToAlbums < ActiveRecord::Migration[5.1]
  def change
    change_column :albums, :count, :integer, :default => 0
  end
end
