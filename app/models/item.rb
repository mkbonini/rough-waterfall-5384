class Item < ApplicationRecord
    has_many :customer_items
    has_many :customers, through: :customer_items

    def self.supermarket_items(id)
        Item.joins(:customers)
            .select('items.*')
            .where(customers: {supermarket_id: id})
            .distinct
    end
end