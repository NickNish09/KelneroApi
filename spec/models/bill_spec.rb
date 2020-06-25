require 'rails_helper'

RSpec.describe Bill, type: :model do
  describe "#close_bill" do
    before do
      @bill = create(:bill)
    end

    it 'should set the current moment to closed_in attribute of the bill' do
      @bill.close_bill
      expect(@bill.closed_in).not_to be_nil
    end
  end
end
