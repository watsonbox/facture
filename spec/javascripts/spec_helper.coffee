# Teaspoon includes some support files, but you can use anything from your own support path too.
# require support/jasmine-jquery-1.7.0
# require support/jasmine-jquery-2.0.0
# require support/sinon
# require support/your-support-file
#
# PhantomJS (Teaspoons default driver) doesn't have support for Function.prototype.bind, which has caused confusion.
# Use this polyfill to avoid the confusion.
#= require support/bind-poly
#
# Deferring execution
# If you're using CommonJS, RequireJS or some other asynchronous library you can defer execution. Call
# Teaspoon.execute() after everything has been loaded. Simple example of a timeout:
#
# Teaspoon.defer = true
# setTimeout(Teaspoon.execute, 1000)
#
# Matching files
# By default Teaspoon will look for files that match _spec.{js,js.coffee,.coffee}. Add a filename_spec.js file in your
# spec path and it'll be included in the default suite automatically. If you want to customize suites, check out the
# configuration in config/initializers/teaspoon.rb
#
# Manifest
# If you'd rather require your spec files manually (to control order for instance) you can disable the suite matcher in
# the configuration and use this file as a manifest.
#
# For more information: http://github.com/modeset/teaspoon
#
# You can require your own javascript files here. By default this will include everything in application, however you
# may get better load performance if you require the specific files that are being used in the spec that tests them.
#= require application

document.write("<script type='text/x-handlebars'><div id='ember-testing' class='container' style='margin: 0 auto; width: 1200px;'>{{render 'navbar'}}{{outlet}}</div></script>")

Facture.setupForTesting()
Facture.injectTestHelpers()

Facture.ApplicationAdapter = DS.FixtureAdapter.extend();

Facture.invoiceSummaryData = [[1375308000000,"0.0"],[1377986400000,"0.0"],[1380578400000,"0.0"],[1383260400000,"0.0"],[1385852400000,"240.0"],[1388530800000,"0.0"],[1391209200000,"0.0"],[1393628400000,"1803.43"],[1396303200000,"0.0"],[1398895200000,"0.0"],[1401573600000,"0.0"],[1404165600000,"0.0"]]
Facture.config = { default_currency: 'EUR' }

QUnit.testStart = ->
  Facture.reset()