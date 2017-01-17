source 'https://rubygems.org'

gemspec

group :development, :test do
  gem 'capybara'
  gem 'launchy'
  gem 'rspec', '~> 3.0'
  gem 'rspec-collection_matchers'
  gem 'rspec-rails'
  gem 'sqlite3'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'mailcatcher'
  gem 'web-console', '~> 2.0'
end

group :test do
  gem 'database_cleaner'
  gem 'email_spec'
  gem 'minitest' # included to solve a problem executing rspec
  gem 'poltergeist'
  gem 'shoulda-matchers'
  gem 'turnip'
end

group :production do
  gem 'pg'
  gem 'whenever', require: false
end
