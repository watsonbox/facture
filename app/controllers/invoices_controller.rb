class InvoicesController < ApplicationController
  before_action :set_invoice, only: [:show, :edit, :update, :destroy]
  respond_to :json, :pdf

  def index
    @invoices = Invoice.all
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

  def update
    respond_with Invoice.update(params[:id], invoice_params)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_invoice
    @invoice = Invoice.find(params[:id])
  end

  def invoice_params
    params.require(:invoice).permit(:reference, :date)
  end
end
