source 'https://rubygems.org'

# Ruby Version
# ruby "2.2.1"

# Adding Sinatra Drivers
gem 'sinatra'
gem 'sinatra-contrib'
gem 'sinatra-flash', '~> 0.3.0'

# Adding thin gem as advised
gem 'thin'

# Adding ActiveRecord and Database Components
gem 'activerecord'
gem 'activesupport'
gem 'sinatra-activerecord'

# Adding Database elements
gem 'pg'

# Adding rake for management
gem 'rake'

# Adding rspec for running unit testing
gem 'rspec'

# password
gem "bcrypt-ruby", "~> 3.0.1"

#pagination
gem 'will_paginate', '~> 3.1'

#friendly url
gem 'friendly_id', '~> 5.1.0'
gem 'shotgun'

group :development, :test do
	# Adding shotgun for local web hosting
end

group :production do
	# Heroku
	# ==================
	gem 'rails_12factor' # Heroku Gem Supports
	gem 'puma' # Using puma for
end