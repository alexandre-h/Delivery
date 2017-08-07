class CreateRestaurants < ActiveRecord::Migration[5.0]
  def change
    create_table :restaurants do |t|
      t.integer :x
      t.integer :y
      t.integer :cooking_time

      t.timestamps
    end
  end
end
