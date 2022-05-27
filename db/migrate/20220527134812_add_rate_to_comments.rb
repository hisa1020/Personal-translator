class AddRateToComments < ActiveRecord::Migration[7.0]
  def change
    add_column :comments, :rate, :float
  end
end
