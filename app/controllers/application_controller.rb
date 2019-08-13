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

            # user cannot view item index if not logged in
            # user cannot view items by user/slug if not logged in
            # user cannot view new item page if not logged in
            # user cannot view individual items if not logged in
            def authenticate
                redirect '/' if !logged_in?
            end
        end
end