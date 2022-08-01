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
end