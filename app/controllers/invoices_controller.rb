class InvoicesController < ApplicationController
  before_action :set_invoice, only: [:show, :edit, :update, :destroy]

  def index
    @invoices = Invoice.all
  end

  def show
    respond_to do |format|
      format.pdf do
        send_data(@invoice.render_pdf, filename: 'test', type: 'application/pdf', disposition: 'inline')
      end
      format.html
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_invoice
    @invoice = Invoice.find(params[:id])
  end
end
