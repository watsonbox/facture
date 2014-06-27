class AddUnitToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :unit, :integer
  end
end
