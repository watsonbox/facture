module InvoicesHelper
  def invoice_summary_data
    javascript_tag do
      "Facture.invoiceSummaryData = #{InvoiceSummaryCalculator.subtotals_by_month.to_json.html_safe};".html_safe
    end
  end
end