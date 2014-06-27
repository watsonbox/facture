Payday::Config.default.company_name = Figaro.env.company_name
Payday::Config.default.company_details = Figaro.env.company_description
Payday::Config.default.date_format = '%b %-d, %Y'
Payday::Config.default.renderer = Payday::ModernPdfRenderer.new
