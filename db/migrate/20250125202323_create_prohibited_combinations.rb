class CreateProhibitedCombinations < ActiveRecord::Migration[8.0]
  def change
    create_table :prohibited_combinations do |t|
      t.references :customization_item, null: false, foreign_key: { to_table: :customization_items }
      t.references :prohibited_item, null: false, foreign_key: { to_table: :customization_items }

      t.timestamps
    end

    add_index :prohibited_combinations, [ :customization_item_id, :prohibited_item_id ], unique: true, name: 'index_prohibited_combinations_uniqueness'
  end
end
