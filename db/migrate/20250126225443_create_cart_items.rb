class CreateCartItems < ActiveRecord::Migration[8.0]
  def change
    create_table :cart_items do |t|
      t.belongs_to :cart, null: false, foreign_key: true
      t.belongs_to :purchasable, null: false, polymorphic: true

      t.timestamps
    end
  end
end
