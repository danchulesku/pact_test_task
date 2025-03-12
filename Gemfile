# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.3.0'

gem 'active_interaction', '~> 5.5'
gem 'pg', '~> 1.1'
gem 'puma', '>= 5.0'
gem 'rails', '~> 7.1.5', '>= 7.1.5.1'

group :development, :test do
  gem 'byebug'
  gem 'rubocop-rails'
  gem 'rubocop-rspec'
end

gem 'brakeman', group: :development

group :test do
  gem 'factory_bot_rails'
  gem 'rspec-openapi', '0.7.2', git: 'https://github.com/exoego/rspec-openapi',
                                ref: '375aed5d0baac2b7a9071c45a007883d30b58732'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
end
