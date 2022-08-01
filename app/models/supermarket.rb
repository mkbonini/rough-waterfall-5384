class Supermarket < ApplicationRecord
  has_many :customers

  def most_popular
    test = Item.joins(:customer_items, :customers)
            .select('items.*, count(*)')
            .group('id')
            .where(customers: {supermarket_id: id})
            .order('count desc')
            .limit(3)
  end
end