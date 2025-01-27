class CreateCarts < ActiveRecord::Migration[8.0]
  def change
    create_table :carts do |t|
      t.decimal :total_price, precision: 17, scale: 2, null: false

      t.timestamps
    end
  end
end
