class Invoice < ActiveRecord::Base
  validates :reference, presence: true, length: { maximum: 255 }
  validates :project, :currency, :date, presence: true

  belongs_to :project
  has_many :line_items, dependent: :destroy

  delegate :client_name, to: :project
  delegate :client_address, to: :project

  include Payday::Invoiceable

  def client_name_and_address
    "#{client_name}\n#{client_address}"
  end

  # Some aliases and stubs to make invoices conform to Payday's Invoiceable interface
  alias_method :bill_to, :client_name_and_address
  alias_attribute :invoice_number, :reference
  def paid_at; nil end
  def due_at; date + 1.month end
end
