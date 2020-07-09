require 'rails_helper'

RSpec.describe "/v1/waiter/tables", type: :request do
  # adjust the attributes here as well.

  # This should return the minimal set of values that should be in the headers
  # in order to pass any filters (e.g. authentication) defined in
  # TablesController, or in your router and rack
  # middleware. Be sure to keep this updated too.

  let(:valid_headers) {
    @restaurant = Restaurant.find_by(subdomain: 'app')
    @waiter = create(:waiter, restaurant: @restaurant)
    headers = {Subdomain: 'app', Authorization: @waiter.token}
    headers
  }

  describe "GET /index" do
    TABLES_AMOUNT = 3
    before do
      TABLES_AMOUNT.times{ create(:table) }
      get "http://app.example.com/v1/waiters/tables", headers: valid_headers
    end

    it "renders a successful response" do
      expect(response).to be_successful
    end

    it 'should return the total amount of tables' do
      expect(JSON.parse(response.body).length).to eq TABLES_AMOUNT
    end

    it 'should return the total amount of tables' do
      expect(JSON.parse(response.body).length).to eq TABLES_AMOUNT
    end

    it 'should return each table necessary stats' do
      attributes_needed = %w(id number x y width height rotation fill table_name bill)
      attributes_not_needed = %w(users final_bill final_bill_number total_bill_items)

      attributes_needed.each do |att|
        expect(JSON.parse(response.body).first.key? att).to be_truthy # check if the hash has the specific keys needed
      end

      attributes_not_needed.each do |att|
        expect(JSON.parse(response.body).first.key? att).to be_falsey # don't want useless data to the client side
      end
    end
  end

  describe "GET /show" do
    before do
      @table = create(:table)
      get "http://app.example.com/v1/waiters/tables/#{@table.id}", params: {}, headers: valid_headers
    end

    it "renders a successful response" do
      expect(response).to have_http_status(:ok)
    end
  end
end
