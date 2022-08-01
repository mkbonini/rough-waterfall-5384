require 'rails_helper' 

RSpec.describe 'Supermarket Show Page' do 
    it 'supermarket name' do
        supermarket_1 = Supermarket.create!(name: 'Soopers', location: 'Denver')

        visit "/supermarkets/#{supermarket_1.id}"

        expect(page).to have_content('Soopers')
    end

    it 'has a link to supermarket items index page' do
        supermarket_1 = Supermarket.create!(name: 'Soopers', location: 'Denver')

        visit "/supermarkets/#{supermarket_1.id}"

        expect(page).to have_link('View All Items')

        click_on('View All Items')
        expect(current_path).to eq("/supermarkets/#{supermarket_1.id}/items")
    end

    it 'lists the 3 most popular items by number of associated customers' do
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

        within "#popular-items" do
            expect(page).to have_content("1. bayblade")
            expect(page).to have_content("2. ferbie")
            expect(page).to have_content("3. pet rock")
            expect(page).to_not have_content("pencil")
        end

    end
end