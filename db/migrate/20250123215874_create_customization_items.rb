class CreateCustomizationItems < ActiveRecord::Migration[8.0]
  def change
    create_table :customization_items do |t|
      t.string :name, null: false
      t.decimal :price, precision: 17, scale: 2, null: false
      t.boolean :in_stock, default: true
      t.belongs_to :customization, null: false, foreign_key: true

      t.timestamps
    end
  end
end
