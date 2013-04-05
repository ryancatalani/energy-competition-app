class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.integer :shower_time
      t.integer :personal_lightbulbs
      t.integer :shared_lightbulbs
      t.integer :plugged_in
      t.integer :recycled_items
      t.integer :user_id
      t.integer :room
      t.integer :floor

      t.timestamps
    end
  end
end
