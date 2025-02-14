require 'rails_helper' 

RSpec.describe 'supermarkets items index Page' do 
    it 'shows a list of all items that belong to a store' do
        supermarket_1 = Supermarket.create!(name: 'Soopers', location: 'Denver')
        supermarket_2 = Supermarket.create!(name: 'Sprouts', location: 'Fort Collins')
        customer = Customer.create!(name: 'Mike Bonini', supermarket_id: supermarket_1.id)
        customer_2 = Customer.create!(name: 'Mike Dao', supermarket_id: supermarket_1.id)
        customer_3 = Customer.create!(name: 'John Snow', supermarket_id: supermarket_2.id)
        item_1 = Item.create!(name: 'pet rock', price: 1000)
        item_2 = Item.create!(name: 'ferbie', price: 100)
        item_3 = Item.create!(name: 'bayblade', price: 10)
        CustomerItem.create!(customer: customer, item: item_1)
        CustomerItem.create!(customer: customer, item: item_2)
        CustomerItem.create!(customer: customer_2, item: item_2)
        CustomerItem.create!(customer: customer_3, item: item_3)

        visit "/supermarkets/#{supermarket_1.id}/items"

        within "#item-list" do
            expect(page).to have_content('pet rock')
            expect(page).to have_content('ferbie')
            expect(page).to_not have_content('bayblade')
        end
    end
end