class Utils
  class << self
    # Extracted from Monetize gem
    def money_from_bigdecimal(value, currency)
      currency = Money::Currency.wrap(currency)
      value = value * currency.subunit_to_unit
      value = value.round unless Money.infinite_precision
      Money.new(value, currency)
    end
  end
end