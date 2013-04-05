class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.integer :room
      t.string :email
      t.string :phone
      t.integer :floor

      t.timestamps
    end
  end
end
