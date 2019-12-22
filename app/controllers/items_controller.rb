class ItemsController < ApplicationController

  get '/items' do
    authenticate
    @user = current_user
    @items = Item.all
    erb :"store/items"
  end

  get '/items/new' do
    authenticate
    @item = Item.new
    erb :"/store/new_item"
  end

  post '/items' do
    @item = Item.create(title: params[:title], description: params[:description], price: params[:price], user: current_user, image: params[:image])
      
    if @item.errors.any?
      erb :"/store/new_item"
    else
      erb :"store/show_item"
    end
  end

  get '/items/:id' do  
    @failed = false
    authenticate
    @item = Item.find_by_id(params[:id])
    redirect '/items' if @item.nil?
    #not_found if @item.nil?
    erb :"store/show_item"
  end

  get '/items/:id/edit' do
    @item = Item.find_by(id: params[:id])
    authenticate

    if logged_in? && @item.user_id == current_user.id
      erb :"store/edit_item"
    else
      @failed = true
      erb :"store/show_item"
    end
  end

  patch '/items/:id' do
    @item = Item.find_by(id: params[:id])
    # not_found if !@item
    @item.update(title: params[:title], description: params[:description], price: params[:price], image: params[:image])
            
    if @item.errors.any?
      erb :"/store/edit_item"
    else
      erb :"store/show_item"
    end
  end

  delete '/items/:id' do
    item = Item.find_by_id(params[:id])
    item.delete if item.user_id == current_user.id
    
    redirect '/items'
  end

  post '/items/search' do
    @user = current_user
    @word = params[:search]
    @items = Item.where("title LIKE ?", "%#{params[:search]}%")
    @search = true
    erb :'store/items'
  end

end