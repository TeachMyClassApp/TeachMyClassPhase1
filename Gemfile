source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.3'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'bootstrap-sass', '~> 3.3.7'
#Login funct
gem 'devise', '~>4.2'
# in app notifications 
gem 'toastr-rails', '~>1.0'
#social logins
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-twitter'
gem 'omniauth-google-oauth2'
#photo attachment
gem "paperclip", ">= 5.2.0"
gem 'carrierwave', '~> 1.0'
gem 'mini_magick', '3.8.0'
gem 'dropzonejs-rails' 
#icons
gem "font-awesome-rails"
#photo storage
#gem 'aws-sdk', '~> 2.8'
gem 'aws-sdk-s3', '~> 1.0.0.rc2'
#google maps location
gem 'geocoder', '~> 1.4'
#jquery date picker and price slider
gem 'jquery-ui-rails', '~> 5.0'
#search function
gem 'ransack', '~> 1.7'
#twilio sms verification
gem 'twilio-ruby', '~> 4.11.1'
#calendar
gem 'fullcalendar-rails', '~> 3.4.0'
#booking selector date and time
gem 'momentjs-rails', '>= 2.9.0'
gem 'bootstrap3-datetimepicker-rails', '~> 4.17.47'
#stripe for payments
gem 'stripe', '~> 3.0.0'
#card visual for payments
gem 'rails-assets-card', source: 'https://rails-assets.org'
#env
gem 'figaro'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
end 

group :production do
gem 'pg'
gem 'rails_12factor'
end
