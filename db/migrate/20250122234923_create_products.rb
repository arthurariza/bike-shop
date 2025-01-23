class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.boolean :in_stock, default: true
      t.decimal :price, precision: 17, scale: 2, null: false
      t.belongs_to :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
