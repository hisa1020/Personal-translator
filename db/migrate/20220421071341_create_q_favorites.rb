class CreateQFavorites < ActiveRecord::Migration[7.0]
  def change
    create_table :q_favorites do |t|
      t.references :user, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
