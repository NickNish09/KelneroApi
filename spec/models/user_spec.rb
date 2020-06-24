require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#current_command' do
    before do
      COMMAND_AMOUNT = 4
      @user = create(:user)

      COMMAND_AMOUNT.times do |i|
        create(:command, user: @user, final_bill: 12.2 + i + 1)
      end
    end

    it 'should have the last command of the user' do
      expect(@user.current_command.final_bill).to eq COMMAND_AMOUNT + 12.2
    end
  end
end
