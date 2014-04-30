require 'spec_helper'

describe "Invoices" do
  describe "GET /invoice" do
    let!(:invoice) { create(:invoice) }

    it "renders an invoice" do
      get invoice_path(id: invoice.id, format: 'pdf')
      expect(response.status).to be(200)
    end
  end
end
