class ItemsController < ApplicationController

    # items index
    get '/items' do

        erb :"/store/items"
    end

end