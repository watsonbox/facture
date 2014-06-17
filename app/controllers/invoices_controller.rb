class InvoicesController < ApplicationController
  before_action :set_invoice, only: [:show, :edit, :update, :destroy]
  respond_to :json, :pdf

  def index
    if params[:project_id].present?
      respond_with Project.find(params[:project_id]).invoices
    else
      respond_with Invoice.all
    end
  end

  def show
    respond_to do |format|
      format.pdf do
        send_data(@invoice.render_pdf, filename: 'test', type: 'application/pdf', disposition: 'inline')
      end
      format.json do
        respond_with @invoice
      end
    end
  end

  # Expects :line_items and will save them exactly as received
  def update
    @invoice.attributes_with_line_items = invoice_params
    respond_with @invoice.save!
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_invoice
    @invoice = Invoice.find(params[:id])
  end

  def invoice_params
    params.require(:invoice).permit(:reference, :date, { :line_items => [:description, :price, :quantity, :invoice_id, :id] })
  end
end
