class ItemsController < ApplicationController
    def index
        # supermarket = Supermarket.find(params[:supermarket_id])
        @items = Item.joins(:customers)
            .select('items.*')
            .where(customers: {supermarket_id: params[:supermarket_id]})
            .distinct
    end
end