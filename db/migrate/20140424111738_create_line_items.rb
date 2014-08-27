class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.references :invoice, index: true
      t.string :description, null: false
      t.decimal :quantity, null: false, default: 1, precision: 8, scale: 2
      t.decimal :price, null: false, default: 0, precision: 8, scale: 2

      t.timestamps
    end
  end
end
