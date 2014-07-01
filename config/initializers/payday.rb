Payday::Config.default.company_name = Figaro.env.company_name
Payday::Config.default.company_details = Figaro.env.company_description
Payday::Config.default.date_format = '%b %-d, %Y'
Payday::Config.default.renderer = Payday::ModernPdfRenderer.new

Money.default_currency = Money::Currency.new(Figaro.env.default_currency || 'EUR')

# Redefine EUR currency to show symbol after amount
Money::Currency.register({
  priority: 2,
  iso_code: "EUR",
  name: "Euro",
  symbol: "€",
  alternate_symbols: [],
  subunit: "Cent",
  subunit_to_unit: 100,
  symbol_first: false,
  html_entity: "&#x20AC;",
  decimal_mark: ",",
  thousands_separator: ".",
  iso_numeric: "978"
})