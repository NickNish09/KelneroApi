require 'rails_helper'

RSpec.describe Order, type: :model do
  ORDERS_QTY = 5

  describe "#self.total_orders" do
    before do
      ORDERS_QTY.times do |i|
        create(:order, quantity: i + 1) # criar pedidos com quantidades diferentes
      end
    end

    it 'should return the total amount of order (by quantity of each items)' do
      expect(Order.total_orders).to eq (1 + 2 + 3 + 4 + 5) # soma das quantidades
    end
  end
  
  describe "#restaurant" do
    before do
      @order = create(:order)
    end

    it 'should return the current restaurant of the order' do
      expect(@order.restaurant.subdomain).to eq "app"
      expect(@order.restaurant.name).to eq "App"
    end
  end

  describe "#as_json" do
    before do
      @order = create(:order)
    end

    it 'should return the id, item and quantity as a json' do
      order_as_json = @order.as_json
      expect(order_as_json[:id]).to eq @order.id
      expect(order_as_json[:item][:name]).to eq @order.item.name
    end
  end
end
