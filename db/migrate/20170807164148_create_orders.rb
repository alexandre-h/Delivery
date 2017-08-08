class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.references :customer, foreign_key: true
      t.references :restaurant, foreign_key: true
      t.references :rider, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
