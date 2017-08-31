class AddFirstNameToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :firstname, :string
    add_column :users, :lastname, :string
    add_column :users, :gender, :string
    add_column :users, :dob, :date
    add_column :users, :avater, :string
    add_column :users, :status_email, :boolean
    add_column :users, :count, :integer
    add_column :users, :remember_me, :boolean
    add_column :users, :avatar, :string
  end
end
