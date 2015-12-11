class AlterWalksAddUserIdColumn < ActiveRecord::Migration
  def change
    add_column :walks, :user_id, :integer
    add_index :walks, :user_id
  end
end
