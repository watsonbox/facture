class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.references :project, index: true, null: false
      t.string :reference, null: false
      t.string :currency, null: false
      t.date :date, null: false

      t.timestamps
    end
  end
end
