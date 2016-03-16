class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :board_id
      t.text :content

      t.timestamps null: false
      t.index :board_id
    end
  end
end
