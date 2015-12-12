class CreateUsersettings < ActiveRecord::Migration
  def change
    create_table :usersettings do |t|
      t.integer :userstride
      t.integer :strideunit, :default => 1
      t.integer :distanceunit, :default => 1
      t.integer :user_id
      t.timestamps
    end
    add_index :usersettings, :user_id
  end
end
