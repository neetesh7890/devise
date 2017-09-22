class RenameColumnToUser < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :firstname, :name
  end
end
