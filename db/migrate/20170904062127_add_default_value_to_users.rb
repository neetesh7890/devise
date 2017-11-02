class AddDefaultValueToUsers < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :count, :integer, :default => 0
  end
end
