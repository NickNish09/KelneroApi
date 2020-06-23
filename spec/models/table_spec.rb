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
end
