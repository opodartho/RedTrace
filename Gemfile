source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.1'

gem 'acts_as_tenant'
gem 'administrate'
gem 'bootsnap', require: false
gem 'cssbundling-rails'
gem 'devise'
gem 'doorkeeper'
gem 'jbuilder'
gem 'jsbundling-rails'
gem 'pg'
gem 'puma'
gem 'rails'
gem 'redis'
gem 'rotp'
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'turbo-rails'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :development, :test do
  gem 'factory_bot_rails'
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'dotenv-rails'
end

group :development do
  gem 'pry-rails'
  gem 'rack-mini-profiler'
  gem 'rubocop'
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end
