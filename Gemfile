source 'https://rubygems.org'

gem 'rails', '4.1.1'
gem 'mysql2'
gem 'sass-rails', '~> 4.0.2'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'haml-rails'
gem 'ember-rails'
gem 'active_model_serializers', '~> 0.8.0' # Hold here for now since can't use path helpers in 0.9
gem 'ember-source'
gem 'emblem-rails'
gem 'emblem-source', git: 'https://github.com/machty/emblem.js.git' # See https://github.com/machty/emblem.js/issues/182
gem 'barber-emblem', git:'https://github.com/simcha/barber-emblem.git' # See https://github.com/machty/emblem.js/issues/182
gem 'momentjs-rails'
gem 'accountingjs-rails'
gem 'bootstrap-datepicker-rails'
gem 'figaro'
gem 'jquery-rails'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'payday', git: 'https://github.com/watsonbox/payday.git', branch: 'custom_styling'
gem 'puma'
gem 'rb-readline' # http://stackoverflow.com/questions/25325543/rails-console-not-working-with-dokku-on-digital-ocean

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring', group: :development

group :development, :test do
  gem 'debugger'
  gem 'rspec-rails', '~> 3.0.0.beta2'
  gem 'factory_girl_rails'
  gem 'quiet_assets'
  gem 'teaspoon'
  gem 'coveralls', require: false
end

group :production do
  gem 'rails_12factor'
end