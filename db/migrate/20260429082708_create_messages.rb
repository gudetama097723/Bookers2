class CreateMessages < ActiveRecord::Migration[8.0]
  def change
    create_table :messages do |t|
      t.references :room, null: false
      t.references :user, null: false
      t.string :content, null: false, limit: 140
      t.timestamps
    end
  end
end
