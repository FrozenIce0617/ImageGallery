class AddUserIdToPins < ActiveRecord::Migration[5.2]
  def change
    add_column :pins, :user_id, :integer
    add_index :pins, :user_id
  end
end
