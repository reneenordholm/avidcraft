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

end