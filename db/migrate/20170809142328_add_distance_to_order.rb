class AddDistanceToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :distance, :decimal, precision: 5
  end
end
