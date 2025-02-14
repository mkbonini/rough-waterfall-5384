require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'relationships' do
    it { should belong_to :supermarket }
    it { should have_many :customer_items }
    it { should have_many(:items).through :customer_items }
  end

  describe 'instance methods' do
    it 'calculates total price' do
      supermarket_1 = Supermarket.create!(name: 'Soopers', location: 'Denver')
      # supermarket_2 = Supermarket.create!(name: 'Sprouts', location: 'Fort Collins')
      customer = Customer.create!(name: 'Mike Bonini', supermarket_id: supermarket_1.id)
      item_1 = Item.create!(name: 'pet rock', price: 1000)
      item_2 = Item.create!(name: 'ferbie', price: 100)
      item_3 = Item.create!(name: 'bayblade', price: 10)
      CustomerItem.create!(customer: customer, item: item_1)
      CustomerItem.create!(customer: customer, item: item_2)

      expect(customer.total_price).to eq(1100)
    end
  end
end