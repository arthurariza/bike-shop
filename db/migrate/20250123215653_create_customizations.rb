class CreateCustomizations < ActiveRecord::Migration[8.0]
  def change
    create_table :customizations do |t|
      t.string :name, null: false
      t.belongs_to :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
