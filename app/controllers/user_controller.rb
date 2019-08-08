class UserController < ApplicationController

    # create
    get '/signup' do
        if logged_in?
            redirect "/items"
        end
    
    erb :"users/create_user"
    end

     # create 
     post '/signup' do
        # create user
        user = User.new(username: params[:username], email: params[:email], password: params[:password])

        # does not let a user sign up without a username
        # does not let a user sign up without an email
        # does not let a user sign up without a password
        if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
            # save user to db
            user.save
            # adds user_id to sessions hash
            # log user in
            session[:user_id] = user.id
            # signup directs user to twitter index
            redirect "/items"
        else
            redirect "/signup"
        end
    end

    get '/login' do
        # does not let user view login page if already logged in
        if logged_in?
            redirect "/items"
        end

        # loads the login page
        erb :"/users/login"
    end



end