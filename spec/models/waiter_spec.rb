require 'rails_helper'

RSpec.describe Waiter, type: :model do
  describe "#set_auth_code" do
    before do
      @waiter = create(:waiter)
    end

    it 'should be run before a waiters is created to set his auth code' do
      expect(@waiter.auth_code).to_not be_nil
    end

    it 'should generate a auth code with 6 digits' do
      expect(@waiter.auth_code.length).to eq 6
    end
  end

  describe "#set_token" do
    before do
      @waiter = create(:waiter)
    end

    it 'should generate a token to the waiters' do
      expect(@waiter.token).to_not be_nil
    end
  end
end
