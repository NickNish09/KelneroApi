require 'rails_helper'

RSpec.describe "V1::Managers", type: :request do
  describe "#check_if_owner" do
    before do
      @controller = V1::ManagerController.new()
    end

    it 'should block unauthorized requests' do
      # @controller.request.host = "app.example.com"
      # @controller.instance_eval{ check_if_owner }.should eql("oi")
    end
  end
end
