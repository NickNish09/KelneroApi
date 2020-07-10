require 'rails_helper'

RSpec.describe "V1::Waiters::Menus", type: :request do
  let(:valid_headers) {
    @restaurant = Restaurant.find_by(subdomain: 'app')
    @waiter = create(:waiter, restaurant: @restaurant)
    headers = {Subdomain: 'app', Authorization: @waiter.token}
    headers
  }

  describe "GET /index" do
    ITEMS_AMOUNT = 3

    before do
      ITEMS_AMOUNT.times do
        create(:item)
      end
      get "http://app.example.com/v1/waiters/menus", headers: valid_headers
    end

    it "renders a successful response" do
      expect(response).to be_successful
    end

    it 'should return the total amount of tables' do
      expect(JSON.parse(response.body)['data'].length).to eq ITEMS_AMOUNT
    end

    it 'should return each table necessary stats' do
      attributes_needed = %w(id name price image_url available)
      attributes_not_needed = %w(quantity created_at updated_at categories formated_created_at formated_price total_orders)

      attributes_needed.each do |att|
        expect(JSON.parse(response.body)['data'].first['attributes'].key? att).to be_truthy # check if the hash has the specific keys needed
      end

      attributes_not_needed.each do |att|
        expect(JSON.parse(response.body)['data'].first['attributes'].key? att).to be_falsey # don't want useless data to the client side
      end
    end
  end
end
