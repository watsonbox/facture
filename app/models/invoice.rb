class Invoice < ActiveRecord::Base
  validates :reference, presence: true, length: { maximum: 255 }
  validates :project, :currency, :date, presence: true

  belongs_to :project
  has_many :line_items, dependent: :destroy, autosave: true

  delegate :client_name, to: :project
  delegate :client_address, to: :project

  include Payday::Invoiceable

  UNITS = {
    1 => :hours,
    2 => :days
  }

  def client_name_and_address
    "#{client_name}\n#{client_address}"
  end

  # Some aliases and stubs to make invoices conform to Payday's Invoiceable interface
  alias_method :bill_to, :client_name_and_address
  alias_attribute :invoice_number, :reference
  def paid_at; nil end
  def paid?; paid end
  def due_at; date + 1.month end
  def refunded_at; nil end

  def attributes_with_line_items=(params)
    InvoiceAttributeUpdater.new(self).update_attributes(params)
  end

  def unit_name
    UNITS[unit] || :days
  end

  def subtotal_in_default_currency
    Money.add_rate(currency, Money.default_currency, default_currency_exchange_rate || 1)
    Utils.money_from_bigdecimal(subtotal, currency).exchange_to(Money.default_currency)
  end

  def payday_translation(key)
    case key
      when 'line_item.quantity' then unit_name.to_s.upcase
    end
  end
end
