class AddScreenNameAndBioAndLocationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :screen_name, :string
    add_column :users, :bio, :string
    add_column :users, :location, :string
  end
end
