Facture.currency_symbols = {
  'USD': '$',  # US Dollar
  'EUR': '€',  # Euro
  'CRC': '₡',  # Costa Rican Colón
  'GBP': '£',  # British Pound Sterling
  'ILS': '₪',  # Israeli New Sheqel
  'INR': '₹',  # Indian Rupee
  'JPY': '¥',  # Japanese Yen
  'KRW': '₩',  # South Korean Won
  'NGN': '₦',  # Nigerian Naira
  'PHP': '₱',  # Philippine Peso
  'PLN': 'zł', # Polish Zloty
  'PYG': '₲',  # Paraguayan Guarani
  'THB': '฿',  # Thai Baht
  'UAH': '₴',  # Ukrainian Hryvnia
  'VND': '₫',  # Vietnamese Dong
}

# Create objects for use with Ember.Select
Facture.currencies = $.map Facture.currency_symbols, (value, key) -> { name: key, symbol: "#{value} - #{key}" }

Ember.Handlebars.registerBoundHelper 'formatMoney', (amount, currency) ->
  currency = Facture.config.default_currency if currency is undefined
  accounting.formatMoney(amount, Facture.currency_symbols[currency])