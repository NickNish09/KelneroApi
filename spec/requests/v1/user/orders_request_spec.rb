require 'rails_helper'

RSpec.describe "V1::User::Orders", type: :request do
  let(:valid_attributes) {
    {orders: {items: [item_id: create(:item).id, quantity: 5, details: ""]}}
  }

  let(:invalid_attributes) {
    {orders: {items: [item_id: nil, quantity: 5, details: ""]}}
  }

  # This should return the minimal set of values that should be in the headers
  # in order to pass any filters (e.g. authentication) defined in
  # BillsController, or in your router and rack
  # middleware. Be sure to keep this updated too.
  let(:valid_headers) {
    @user = create(:user)
    @user.create_new_auth_token
  }

  let(:unauthorized_headers) {
    {}
  }

  USER_BILLS = 5

  describe "GET #index" do
    context "with user signed_in" do
      before do
        headers = valid_headers
        USER_BILLS.times do |i|
          create(:bill, user: @user)
        end
        get "http://app.example.com/v1/user/orders", params: {}, headers: headers
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:success)
      end

      it 'should return all the user bills' do
        expect(JSON.parse(response.body).size).to eq(USER_BILLS)
      end
    end

    context "with user not signed in" do
      before do
        headers = valid_headers
        USER_BILLS.times do |i|
          create(:bill, user: @user)
        end
        get "http://app.example.com/v1/user/orders", params: {}, headers: unauthorized_headers
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(:unauthorized)
      end

      it 'should return an error message' do
        expect(JSON.parse(response.body)['error']).to eq("você precisa estar autenticado para fazer o pedido")
      end
    end
  end

end
