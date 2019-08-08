class UserController < ApplicationController

    # create
    get '/signup' do
        if logged_in?
            redirect "/items"
        end
    
    erb :"users/create_user"
    end

end