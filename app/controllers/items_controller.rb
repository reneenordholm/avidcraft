require 'pry'

class ItemsController < ApplicationController

  # items index
  get '/items' do
    # does not load item index if user is not logged in
    # does load items index if user is logged in
    redirect '/' if !logged_in?

    # set instance variable as current_user via helper method
    @user = current_user

    # makes all items available via instance variable
    @items = Item.all
   
    # loads items index
    erb :"store/items"
  end

  # create
  get '/items/new' do
    # does not let user view new item page if not logged in
    redirect '/' if !logged_in?

    # set class variable for @item to new Item instance so erb can check for errors
    @item = Item.new

    erb :"/store/new_item"
  end

  # create
  post '/items' do
    # item id is set as belonging to logged in user
    # item instance is created and saved to db
    @item = Item.create(title: params[:title], description: params[:description], price: params[:price], user: current_user, image: params[:image])
      
    # if any validations fail upon item creation raises an error in erb
    if @item.errors.any?

      # presents create_user page again, uses cookie to show shows account creation errors
      erb :"/store/new_item"
    else
      # successful item object created, redirects user to list of all items
      redirect '/items'
    end
  end

    # read
    get '/items/:id' do
        # logged in user can view a single item
        # logged out user cannot view a single item
        if logged_in?
            # sets item id to instance variable so that items's data can be viewed
            @item = Item.find_by_id(params[:id])

            erb :"store/show_item"
        else
            # if not logged in redirects user to home page
            redirect to '/'
        end
    end

    # update
    get '/items/:id/edit' do
        # sets item id to instance variable to that item's data can be viewed/edited
        @item = Item.find_by(id: params[:id])

        # lets a user use item edit form if logged in
        # does not let a user edit a item they did not create
        # if user is logged in can edit their own item
        if logged_in? && @item.user_id == current_user.id
            erb :"store/edit_item"
        else
            # does not load edit form if user not logged in, redirects to home page
            redirect '/'
        end
    end

    # update
    patch '/items/:id' do
        # sets item id to instance variable so that items's data can be viewed/edited
        item = Item.find_by(id: params[:id])
    
        # does not let user edit text with blank content
        if !params[:title].empty? && !params[:description].empty? && !params[:price].empty? && !params[:image].empty?
            # update/saves edited item and sends back to that items's page
            item.update(title: params[:title], description: params[:description], price: params[:price], image: params[:image])
            redirect to "/items/#{item.id}"
        else
            # if params empty redirects to edit form
            redirect to "/items/#{item.id}/edit"
        end
    end

    # delete
    delete '/items/:id' do
        # sets item id to instance variable to that item's data can be viewed/edited
        item = Item.find_by_id(params[:id])
    
        # allows user to delete item if logged in
        # does not let user delete item they did not create
        if item.user_id == current_user.id
            item.delete
        end
    
        # send user to item index after deletion
        # does not load/let user delete item if not logged in
        redirect '/items'
    end

end