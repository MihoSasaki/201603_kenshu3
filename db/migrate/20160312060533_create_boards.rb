class CreateBoards < ActiveRecord::Migration
  def change
    create_table :boards do |t|
      t.text :title
      t.integer :user_id
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
      t.index [:user_id, :created_at]
    end
  end
end
