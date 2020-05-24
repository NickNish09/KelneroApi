require 'rails_helper'

RSpec.describe Order, type: :model do
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
