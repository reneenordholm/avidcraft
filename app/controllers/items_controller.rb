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

    # read
    get '/items/:id' do
        # logged in user can view a single item
        # logged out user cannot view a single item
        if logged_in?
            # sets item id to instance variable to that items's data can be viewed
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



end