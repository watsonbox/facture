require 'spec_helper'

describe InvoiceSummaryCalculator do
  describe '.subtotals_by_month' do
    let!(:invoice1) { create(:invoice_with_line_items, :date => Time.now) }     # 49.95 €
    let!(:invoice2) { create(:invoice_with_line_items, :date => Time.now) }     # 49.95 €
    let!(:invoice3) { create(:invoice_with_line_items, :date => 1.month.ago) }  # 49.95 €

    it 'summarizes invoice data by month' do
      expect(InvoiceSummaryCalculator.subtotals_by_month(2)).to eq [
        [1.month.ago.to_time.beginning_of_month.to_i * 1000, BigDecimal.new('49.95')],
        [Time.now.beginning_of_month.to_i * 1000, BigDecimal.new('99.90')]
      ]
    end
  end
end