source 'https://rubygems.org'

gemspec

gem 'puma'

group :development, :test do
  gem 'capybara', '~> 3.15'
  gem 'launchy'
  gem 'rspec', '~> 3.0'
  gem 'rspec-collection_matchers'
  gem 'rspec-rails', '~> 3.9.0'
  gem 'sqlite3', '~> 1.3.0'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'mailcatcher'
  gem 'web-console', '~> 3.1.0'
  gem 'spring'
  gem 'listen', '~> 3.0'
end

group :test do
  gem 'database_cleaner'
  gem 'email_spec'
  gem 'minitest' # included to solve a problem running rspec
  gem 'poltergeist'
  gem 'shoulda-matchers'
  gem 'turnip'
end

group :production do
  gem 'whenever', require: false
end
