class ItemsController < ApplicationController

    # items index
    get '/items' do
        # does not load item index if user is not logged in
        # does load items index if user is logged in
        if logged_in?
            # set instance variable as current_user via helper method
            @user = current_user
            # makes all items available via instance variable
            @items = Item.all

            # loads items index
            erb :'store/items'
        else
            redirect to "/"
         end
    end

  # create
  get '/items/new' do
    # user can view new item form if logged in
    # user can create item if logged in
    # user cannot view new item form if not logged in
    if logged_in?
      erb :'/store/new_item'
    else
      redirect '/'
    end
  end

  # create
  post '/items' do
    # does not let user create a blank item or leave any fields blank
    if !params[:title].empty? && !params[:description].empty? && !params[:price].empty?
      # item is saved as logged in user
      item = Item.create(title: params[:title], description: params[:description], price: params[:price], user: current_user)
      item.save
            
      redirect '/items'
    else
      redirect to '/items/new_item'
    end
  end

    # read
    get '/items/:id' do
        # logged in user can view a single item
        # logged out user cannot view a single item
        if logged_in?
            # sets item id to instance variable so that items's data can be viewed
            @item = Item.find_by_id(params[:id])

            erb :'store/show_item'
        else
            # if not logged in redirects user to home page
            redirect to '/'
        end
    end

    # update
    get '/items/:id/edit' do
        # sets item id to instance variable to that item's data can be viewed/edited
        @item = Item.find_by(params[:id])

        # lets a user use item edit form if logged in
        # does not let a user edit a item they did not create
        # if user is logged in can edit their own item
        if logged_in? && @item.user_id == current_user.id
            erb :'store/edit_item'
        else
            # does not load edit form if user not logged in, redirects to home page
            redirect '/'
        end
    end

    # update
    patch '/items/:id' do
        # sets item id to instance variable to that items's data can be viewed/edited
        item = Item.find_by(id: params[:id])
    
        # does not let user edit text with blank content
        if !params[:title].empty? && !params[:description].empty? && !params[:price].empty?
            # update/saves edited item and sends back to that items's page
            item.update(title: params[:title], description: params[:description], price: params[:price])
            redirect to "/items/#{item.id}"
        else
            # if params empty redirects to edit form
            redirect to "/items/#{item.id}/edit"
        end
    end



end