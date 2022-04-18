class CreateQComments < ActiveRecord::Migration[7.0]
  def change
    create_table :q_comments do |t|
      t.string :q_content
      t.references :user, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
