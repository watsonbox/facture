class LineItemsController < ApplicationController
  respond_to :json

  def index
    if invoice_id = params[:invoice_id]
      respond_with Invoice.find(invoice_id).line_items
    else
      respond_with LineItem.all
    end
  end
end