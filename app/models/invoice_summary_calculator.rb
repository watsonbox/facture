class InvoiceSummaryCalculator
  class << self
    # Reported in the default currency
    def grouped_by_month(months = 12)
      from_date = (Date.today - (months - 1).months).to_time.beginning_of_month

      invoices = {}
      (0...months).each { |i| invoices[i.months.ago.to_time.beginning_of_month.to_i * 1000] = [] }

      invoices_found = Invoice.where(['date >= ?', from_date]).group_by { |i| i.date.to_time.beginning_of_month.to_i * 1000 }
      invoices_found.each { |k,v| invoices[k] = v }

      invoices.sort { |a,b| a[0] <=> b[0] }
    end

    # Reported in the default currency
    def subtotals_by_month(months = 12)
      grouped_by_month(months).map do |month, invoices|
        [
          month,
          (invoices.inject(Money.new(0, Money.default_currency)) { |s,v| s += v.subtotal_in_default_currency }).amount
        ]
      end
    end
  end
end
