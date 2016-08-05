source 'https://rubygems.org'

gem 'rails', '~> 5.0.0'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'
gem 'dotenv-rails', require: 'dotenv/rails-now'
gem 'pundit'
gem 'ar-uuid'
gem 'friendly_id', '~> 5.1.0'
gem 'slugify'
gem 'enumerate_it'
gem 'validates_email_format_of'
gem 'kaminari'
gem 'active_model_serializers', '~> 0.10.0'

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'
group :development, :test do
  gem 'byebug', platform: :mri
  gem 'faker'
  gem 'guard'
  gem 'guard-rspec', require: false
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'factory_girl_rails'
end

group :test do
  gem 'database_cleaner'
  gem 'rspec-rails', '~> 3.4'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'shoulda-kept-respond-with-content-type'
  gem 'brakeman', require: false
  gem 'rails-controller-testing'
  gem 'simplecov', require: false
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
