class ApplicationController < Sinatra::Base

    configure do
        set :public_folder, 'public'
        set :views, 'app/views'
        enable :sessions
        set :session_secret, "secret"
      end

    get '/' do

        # loads the homepage
        erb :index
      end
    
      helpers do
        # checks if user is logged in
            def logged_in?
                !!session[:user_id]
            end
    
        # pulls from session hash to determine the current user
            def current_user
                User.find(session[:user_id])
            end
        end
end