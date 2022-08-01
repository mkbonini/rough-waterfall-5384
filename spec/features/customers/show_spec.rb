require 'rails_helper' 

RSpec.describe 'Customer Show Page' do 
    it 'displays a custoemrs items with supermarket name' do
        supermarket_1 = Supermarket.create!(name: 'Soopers', location: 'Denver')
        # supermarket_2 = Supermarket.create!(name: 'Sprouts', location: 'Fort Collins')
        customer = Customer.create!(name: 'Mike Bonini', supermarket_id: supermarket_1.id)
        item_1 = Item.create!(name: 'pet rock', price: 1000)
        item_2 = Item.create!(name: 'ferbie', price: 100)
        item_3 = Item.create!(name: 'bayblade', price: 10)
        CustomerItem.create!(customer: customer, item: item_1)
        CustomerItem.create!(customer: customer, item: item_2)

        visit "/customers/#{customer.id}"

        within "#item-list" do
            expect(page).to have_content('Item: pet rock - Supermarket: Soopers')
            expect(page).to have_content('Item: ferbie - Supermarket: Soopers')
            expect(page).to_not have_content('bayblade')
        end
    end
end