# Supports assigning attributes with embedded line_items
# Set autosave: true on the association to ensure child updates are saved
class InvoiceAttributeUpdater < Struct.new(:invoice)
  def update_attributes(params)
    params = ActiveSupport::HashWithIndifferentAccess.new(params)
    line_items_params = params[:line_items].to_a

    fake_new_record do
      invoice.line_items = line_items_params.map { |lip| generate_line_item(lip) }
    end

    invoice.attributes = params.except(:line_items)
  end

  private

  def generate_line_item(params)
    (find_line_item(params[:id]) || LineItem.new).tap do |li|
      li.attributes = params
    end
  end

  def find_line_item(id)
    invoice.line_items.find { |li| li.id == id.to_i }
  end

  # Used for assigning line items. This is necessary because we want line item validations errors
  # on the invoice, but assigning invalid line items to an existing record causes them to be
  # immediately saved with an exception raised on any validation errors.
  def fake_new_record
    new_invoice_state = invoice.new_record?
    invoice.instance_variable_set('@new_record', true) unless new_invoice_state
    yield
  ensure
    invoice.instance_variable_set('@new_record', false) unless new_invoice_state
  end
end