require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#current_bill' do
    before do
      BILLS_AMOUNT = 4
      @user = create(:user)

      BILLS_AMOUNT.times do |i|
        create(:bill, user: @user, final_bill: 12.2 + i + 1)
      end
    end

    it 'should have the last bill of the user' do
      expect(@user.current_bill.final_bill).to eq BILLS_AMOUNT + 12.2
    end
  end
end
