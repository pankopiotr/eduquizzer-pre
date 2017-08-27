source 'https://rubygems.org'

# Ruby on Rails
gem 'rails'

# General usage
gem 'bcrypt'
gem 'carrierwave'
gem 'carrierwave-ftp', require: 'carrierwave/storage/ftp' # FTP only
gem 'jbuilder'
gem 'turbolinks'

# Asset pipeline
gem 'coffee-rails'
gem 'haml'
gem 'jquery-rails'
gem 'sass-rails'
gem 'uglifier'

# Web-server app
gem 'puma'

# Front-end
gem 'bootstrap-sass'
gem 'cookies_eu'

# Background tasks
gem 'daemons'
gem 'delayed_job'
gem 'delayed_job_active_record'

# RDBMS
gem 'pg'

group :development, :test do
  # Debugging
  gem 'byebug', platform: :mri
  gem 'rails-controller-testing'
end

group :development do
  # Debugging
  gem 'better_errors'
  gem 'meta_request'
  gem 'web-console'

  # Automated deployment
  gem 'listen'
  gem 'spring'
  gem 'spring-watcher-listen'

  # Automated testing
  gem 'guard'
  gem 'guard-minitest'

  # Prettier reporter
  gem 'minitest-reporters'
end

# Timezone Data (Windows does not include timezone info files)
# noinspection RailsParamDefResolve
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]