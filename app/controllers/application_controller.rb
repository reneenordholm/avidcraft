class ApplicationController < Sinatra::Base

    configure do
        set :public_folder, 'public'
        set :views, 'app/views'
        enable :sessions
        set :session_secret, "secret"
      end

    get '/' do
        
        erb :index
    end
    
    helpers do

        def logged_in?
            !!session[:user_id]
        end

        def current_user
            User.find(session[:user_id])
        end

        def authenticate
            redirect '/' if !logged_in?
        end

        def clean_params(params)
            np = params.dup
            params.each do |k,v|
                np[k] = Rack::Utils.escape_html(v)
            end
            np
        end
    end 

        # not_found do
        #     "Whhaaaattt???"
        # end
end