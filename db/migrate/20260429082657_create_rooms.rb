class CreateRooms < ActiveRecord::Migration[8.0]
  def change
    create_table :rooms do |t|
      t.references :user1, null: false
      t.references :user2, null: false
      t.timestamps
    end
  end
end
