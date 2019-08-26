class UsersController < ApplicationController

    get '/signup' do
        redirect '/items' if logged_in?
        @user = User.new
        erb :"users/create_user"
    end

    post '/signup' do
        @user = User.create(username: params[:username], email: params[:email], password: params[:password])

        if @user.errors.any?
            session[:user_id] = @user.id
            erb :"users/create_user"
        else
            session[:user_id] = @user.id
            redirect '/items'
        end
    end

    get '/login' do
        @failed = false
        redirect '/items' if logged_in?
        erb :"users/login"
    end

    post '/login' do
        user = User.find_by(username: params[:username])

        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect '/items'
        else
            @failed = true
            erb :"users/login"
        end
    end

    get '/users/:slug' do
        authenticate
        @user = User.find_by_slug(params[:slug])  
        erb :"users/show"
    end

    get '/logout' do
        session.clear
        redirect '/'
	end

end