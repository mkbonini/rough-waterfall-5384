require 'rails_helper'

RSpec.describe Supermarket, type: :model do
  describe 'relationships' do
    it { should have_many :customers }
  end

  describe 'instance methods'do
    it 'most_popular lists 3 most popular items by customer associations' do
      supermarket_1 = Supermarket.create!(name: 'Soopers', location: 'Denver')
      # supermarket_2 = Supermarket.create!(name: 'Sprouts', location: 'Fort Collins')
      customer = Customer.create!(name: 'Mike Bonini', supermarket_id: supermarket_1.id)
      customer_2 = Customer.create!(name: 'Mike Dao', supermarket_id: supermarket_1.id)
      customer_3 = Customer.create!(name: 'John Snow', supermarket_id: supermarket_1.id)
      item_1 = Item.create!(name: 'pet rock', price: 1000)
      item_2 = Item.create!(name: 'ferbie', price: 100)
      item_3 = Item.create!(name: 'bayblade', price: 10)
      item_4 = Item.create!(name: 'pencil', price: 10)
      CustomerItem.create!(customer: customer, item: item_1)
      CustomerItem.create!(customer: customer, item: item_2)
      CustomerItem.create!(customer: customer, item: item_3)
      CustomerItem.create!(customer: customer_2, item: item_2)
      CustomerItem.create!(customer: customer_2, item: item_3)
      CustomerItem.create!(customer: customer_3, item: item_3)

      expect(supermarket_1.most_popular).to match_array([item_3,item_2,item_1])
    end
  end
end