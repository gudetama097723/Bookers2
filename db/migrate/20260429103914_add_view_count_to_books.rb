class AddViewCountToBooks < ActiveRecord::Migration[8.0]
  def change
    add_column :books, :view_count, :integer
  end
end
