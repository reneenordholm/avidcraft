# creating an environment variable if not in development
ENV['SINATRA_ENV'] ||= "development"

# bundler loads basic set of processes for our app to run
require 'bundler/setup'
# lets bundler know what our default environment is
Bundler.require(:default, ENV['SINATRA_ENV'])

# determines sql gem to use as well as designate where our db is setup 
ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
)

# app will need everything in the app folder to run
require_all 'app'
