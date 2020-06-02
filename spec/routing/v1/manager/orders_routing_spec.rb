require "rails_helper"

RSpec.describe V1::Manager::OrdersController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/v1/manager/orders").to route_to("v1/manager/orders#index")
    end

    it "routes to #show" do
      expect(get: "/v1/manager/orders/1").to route_to("v1/manager/orders#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/v1/manager/orders").to route_to("v1/manager/orders#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/v1/manager/orders/1").to route_to("v1/manager/orders#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/v1/manager/orders/1").to route_to("v1/manager/orders#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/v1/manager/orders/1").to route_to("v1/manager/orders#destroy", id: "1")
    end
  end
end
