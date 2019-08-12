class UsersController < ApplicationController

    # create
    get '/signup' do
        # does not let user view signup page if already logged in
        redirect '/items' if logged_in?
        
        @user = User.new

        erb :"users/create_user"
    end

     # create 
     post '/signup' do
        # create user
        # save user to db
        @user = User.create(username: params[:username], email: params[:email], password: params[:password])

        # if any validations from User raise an error
        if @user.errors.any?
            # adds user_id to sessions hash, creates cookie
            session[:user_id] = @user.id
            # presents create_user page again, shows account creation errors
            erb :"users/create_user"
        else
            # adds user_id to sessions hash, creates cookie, effectively logging user in
            session[:user_id] = @user.id
            # signup directs user to items index
            redirect '/items'
        end
    end

    get '/login' do
        @failed = false

        # does not let user view login page if already logged in
        redirect '/items' if logged_in?
        
        # loads the login page
        erb :"users/login"
    end

    post '/login' do
        # searches for username in db that matches username entered at login page
        user = User.find_by(username: params[:username])

        # verifies password in db matches password entered at login
        if user && user.authenticate(params[:password])
            # if both username are found/pw matches sets user_id to session id, enabling cookies 
            session[:user_id] = user.id
            # loads the items index after login
            redirect '/items'
        else
            @failed = true
            # if username/pw not found or entered incorrectly sends user back to login page
            erb :"users/login"
        end
    end

    # read
    get '/users/:slug' do
        if !logged_in?
            redirect '/'
        end
        # slugs username
        # finds user based on slug
        @user = User.find_by_slug(params[:slug])  
    
        #shows all of selected user's items
        erb :"users/show"
    end

    get '/logout' do
        # lets a user logout if they are already logged in
        # does not let a user logout if not logged in
        # clears sessions so user cannot access certain areas of site without logging in again
        session.clear
        redirect '/'
	end

end