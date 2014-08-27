class MakeLineItemsQuantityNullable < ActiveRecord::Migration
  def change
    change_column :line_items, :quantity, :decimal, null: true, default: nil, precision: 8, scale: 2
  end
end
