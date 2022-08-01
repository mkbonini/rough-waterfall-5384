class ItemsController < ApplicationController
    def index
        @items = Item.supermarket_items(params[:supermarket_id])
    end
end