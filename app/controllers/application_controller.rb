class ApplicationController < ActiveRecord :: Base

    configure do
        set :views, 'app/views'
        enable :sessions
        set :session_secret, "secret"
    end

    get '/' do
        "Hello World"
    end