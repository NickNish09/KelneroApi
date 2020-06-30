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

  describe "#check_command_stat" do
    context "with only pending orders" do
      before do
        @command = create(:command, status: "pronto")
        @order = create(:order, command: @command)
        @order.status = "pendente"
        @order.save
      end

      it 'should update the command stat to pendente' do
        expect(@command.pendente?).to be_truthy
      end
    end

    context "with only done orders" do
      before do
        @command = create(:command)
        @order = create(:order, command: @command)
        @order.status = "pronto"
        @order.save
      end

      it 'should update the command stat to pronto' do
        expect(@command.pronto?).to be_truthy
      end
    end
  end
end
