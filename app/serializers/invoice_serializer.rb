class InvoiceSerializer < ApplicationSerializer
  attributes :id, :reference, :date, :currency, :paid, :subtotal, :links
  has_one :project

  def links
    {
      line_items: line_items_path(invoice_id: id)
    }
  end
end