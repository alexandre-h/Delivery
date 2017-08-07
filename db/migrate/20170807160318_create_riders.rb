class CreateRiders < ActiveRecord::Migration[5.0]
  def change
    create_table :riders do |t|
      t.integer :x
      t.integer :y
      t.integer :speed

      t.timestamps
    end
  end
end
