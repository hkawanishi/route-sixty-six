class CreateWalks < ActiveRecord::Migration
  def change
    create_table :walks do |t|

      t.integer :step
      t.date :date
      t.float :distance
      t.float :totaldistance

      t.integer :step_id

      t.timestamps
    end
    add_index :walks, :step_id
  end
end
