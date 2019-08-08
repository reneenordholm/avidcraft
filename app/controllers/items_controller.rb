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



end