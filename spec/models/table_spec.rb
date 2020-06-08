require 'rails_helper'

RSpec.describe Table, type: :model do
  include ActionView::Helpers::NumberHelper

  describe "#current_final_bill" do
    before do
      @table = create(:table)
      create(:bill, final_bill: 10.00, table: @table)
      create(:bill, final_bill: 20.50, table: @table)
    end

    it 'should return the sum of all the bills in the table' do
      expect(@table.current_final_bill).to eq number_to_currency(30.50)
    end
  end

  describe "#total_bill_items" do
    before do
      @table = create(:table)
      create(:bill_with_orders, table: @table)
      create(:bill_with_orders, table: @table)
    end

    it 'should return all the items in the bill from all bills' do
      expect(@table.total_bill_items.count).to eq 20
    end
  end
end
