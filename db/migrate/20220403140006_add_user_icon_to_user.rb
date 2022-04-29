class AddUserIconToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :user_icon, :string
  end
end
