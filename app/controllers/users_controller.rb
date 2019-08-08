class UsersController < ApplicationController

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

    post '/login' do
        # searches for username in db that matches username entered at login page
        user = User.find_by(username: params[:username])


        # verifies password in db matches password entered at login
        if user && user.authenticate(params[:password])
            # if both username are found/pw matches sets user_id to session id, enabling cookies 
            session[:user_id] = user.id
            # loads the tweets index after login
            redirect '/items'
        else
            # if username/pw not found or entered incorrectly sends user back to login page
            redirect '/login'
        end
    end



end