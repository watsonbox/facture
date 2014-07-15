# Facture

[![Build Status](http://img.shields.io/travis/watsonbox/facture.svg?style=flat)](https://travis-ci.org/watsonbox/facture)

Facture is a re-write of my original Rails-only invoice management application, using Ember.js with a Rails API back-end. It uses [Payday](https://github.com/commondream/payday/) for rendering PDF invoices.

----------

![Invoices screen](/public/screenshots/invoices.png?raw=true "Invoices screen")

----------

![A PDF invoice](/public/screenshots/pdf_invoice.png?raw=true "A PDF invoice")

----------


## Features

* Create, edit, and show invoices by project
* Show yearly income to date by month, converting to default currency
* Render invoices using [Payday](https://github.com/commondream/payday/)
* Duplicate existing invoices
* Mark invoices as Paid or Pending
* Import time entries from [Redmine](http://www.redmine.org/) (depends on patch)


## Tests

The integration test suite uses Teaspoon with phantomjs. Run them as follows or in the browser at http://localhost:3000/teaspoon.

```
bundle exec rake teaspoon
```

The unit tests are rspec.

```
bundle exec rake
```


## Todo

* Automatic generation of invoice references from client and project codes
* Save exchange rate from [openexchangerates.org](https://openexchangerates.org/) when marking a non default currency invoice as paid
* Increase test coverage
* Write plugin for Redmine to replace patch for importing time entries
* Handle variable hourly rates on Redmine import