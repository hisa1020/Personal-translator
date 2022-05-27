class RemoveRateFromComments < ActiveRecord::Migration[7.0]
  def change
    remove_column :comments, :rate, :float
  end
end
