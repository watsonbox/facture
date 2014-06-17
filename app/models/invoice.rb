class Invoice < ActiveRecord::Base
  validates :reference, presence: true, length: { maximum: 255 }
  validates :project, :currency, :date, presence: true

  belongs_to :project
  has_many :line_items, dependent: :destroy, autosave: true

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

  # Supports assigning attributes with embedded line_items
  # Set autosave: true on the association to ensure child updates are saved
  def attributes_with_line_items=(params)
    params = ActiveSupport::HashWithIndifferentAccess.new(params)

    new_line_items = params[:line_items].to_a.map do |line_item_params|
      line_item = line_items.find { |li| li.id.to_s == line_item_params[:id] }
      line_item ||= LineItem.new
      line_item.attributes = line_item_params
      line_item
    end

    self.line_items = new_line_items
    self.attributes = params.except(:line_items)
  end
end
