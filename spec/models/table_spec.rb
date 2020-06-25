require 'rails_helper'

RSpec.describe Table, type: :model do
  include ActionView::Helpers::NumberHelper

  describe "#current_final_bill" do
    before do
      @table = create(:table)
      create(:command, final_bill: 10.00, table: @table)
      create(:command, final_bill: 20.50, table: @table)
    end

    it 'should return the sum of all the commands in the table' do
      expect(@table.current_final_bill).to eq number_to_currency(30.50)
    end
  end

  describe "#total_command_items" do
    before do
      @table = create(:table)
      create(:command_with_orders, table: @table)
      create(:command_with_orders, table: @table)
    end

    it 'should return all the items in the command from all commands' do
      expect(@table.total_bill_items.count).to eq 1
    end
  end

  describe "#current_final_bill_number" do
    before do
      @table = create(:table)
      create(:command, final_bill: 10.00, table: @table)
      create(:command, final_bill: 20.50, table: @table)
    end

    it 'should return the sum of all commands in the table as float' do
      expect(@table.current_final_bill_number).to eq 30.50
    end
  end

  describe "#current_table_bill" do
    before do
      @table = create(:table)
      @bill = create(:bill, table: @table)
      @command = create(:command_with_orders, table: @table)
    end

    it 'should include all the commands in the current bill of the table' do
      expect(@table.current_table_bill['commands'].count).to eq 1 # it has one command only
    end

    it 'should include all the orders of the commands in the current bill' do
      expect(@table.current_table_bill['commands'][0]['orders'].count).to eq 10 # it has 10 orders from the factory
    end
  end

  describe "#current_orders" do
    context "when there is a current bill" do
      before do
        @table = create(:table)
        @bill = create(:bill, table: @table)
        @command = create(:command_with_orders, table: @table)
      end

      it 'should return all the orders in the current bill of the table' do
        expect(@table.current_orders.count).to eq 10
      end
    end

    context "when the current bill is nil" do
      before do
        @table = create(:table)
      end

      it 'should return an empty array' do
        expect(@table.current_orders).to eq []
      end
    end
  end
end
