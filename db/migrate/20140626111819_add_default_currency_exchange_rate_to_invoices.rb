class AddDefaultCurrencyExchangeRateToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :default_currency_exchange_rate, :float
  end
end
