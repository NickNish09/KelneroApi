require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/v1/manager/orders", type: :request do
  let(:valid_attributes) {
    {order: {item_id: create(:item).id, quantity: 5, details: "", bill_id: create(:bill).id}}
  }

  let(:invalid_attributes) {
    {order: {item_id: nil, quantity: 5, details: ""}}
  }

  let(:valid_update_attributes) {
    {order: {quantity: 5, details: "Com molho"}}
  }

  let(:invalid_update_attributes) {
    {order: {quantity: nil}}
  }

  # This should return the minimal set of values that should be in the headers
  # in order to pass any filters (e.g. authentication) defined in
  # BillsController, or in your router and rack
  # middleware. Be sure to keep this updated too.
  let(:valid_headers) {
    @user_app = User.find_by(email: "app@admin.com")
    headers = @user_app.create_new_auth_token
    headers["Subdomain"] = 'app'
    headers
  }

  let(:unauthorized_headers) {
    {"Subdomain": 'app'}
  }

  RESTAURANT_ORDERS = 5

  describe "GET #index" do
    context "with user signed_in" do
      before do
        headers = valid_headers
        RESTAURANT_ORDERS.times do |i|
          create(:order)
        end
        get "http://app.example.com/v1/manager/orders", params: {}, headers: headers
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:success)
      end

      it 'should return all the restaurant orders' do
        expect(JSON.parse(response.body).size).to eq(RESTAURANT_ORDERS)
      end
    end

    context "with user not signed in" do
      before do
        headers = valid_headers
        RESTAURANT_ORDERS.times do |i|
          create(:bill, user: @user)
        end
        get "http://app.example.com/v1/manager/orders", params: {}, headers: unauthorized_headers
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(:unauthorized)
      end

      it 'should return an error message' do
        expect(JSON.parse(response.body)['error']).to eq("Apenas o dono do restaurante tem acesso à isso")
      end
    end
  end

  describe "POST #create" do
    context "with valid params" do
      before do
        headers = valid_headers
        @orders_count = Order.count
        post "http://app.example.com/v1/manager/orders/", params: valid_attributes, headers: headers
      end

      it 'returns status code created' do
        expect(response).to have_http_status(:created)
      end

      it 'should return the created order' do
        expect(JSON.parse(response.body)['quantity']).to eq(5)
      end

      it 'should create an item in the DB' do
        expect(Order.count).to eq @orders_count + 1
      end
    end

    context "with invalid params" do
      before do
        headers = valid_headers
        @bill = create(:bill, user: @user)
        @bill_orders = @bill.items.count
        post "http://app.example.com/v1/manager/orders/", params: invalid_attributes, headers: headers
      end

      it 'returns status code unprocessable_entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'should return an error message' do
        expect(JSON.parse(response.body)['item'][0]).to eq('é obrigatório(a)')
        expect(JSON.parse(response.body)['bill'][0]).to eq('é obrigatório(a)')
      end

      it 'should not create an item in the DB' do
        expect(@bill.items.count).to eq @bill_orders
      end
    end

    context "with no user authentitication" do
      before do
        headers = valid_headers
        @bill = create(:bill, user: @user)
        post "http://app.example.com/v1/manager/orders/", params: valid_attributes, headers: unauthorized_headers
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(:unauthorized)
      end

      it 'should return an error message' do
        expect(JSON.parse(response.body)['error']).to eq("Apenas o dono do restaurante tem acesso à isso")
      end
    end
  end

  describe "GET #show" do
    context "with user signed_in" do
      before do
        headers = valid_headers
        @order = create(:order)
        get "http://app.example.com/v1/manager/orders/#{@order.id}", params: {}, headers: headers
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:success)
      end

      it 'should return the restaurant order' do
        expect(JSON.parse(response.body)['id']).to eq(@order.id)
      end
    end

    context "with user not signed in" do
      before do
        headers = valid_headers
        @order = create(:order)
        get "http://app.example.com/v1/manager/orders/#{@order.id}", params: {}, headers: unauthorized_headers
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(:unauthorized)
      end

      it 'should return an error message' do
        expect(JSON.parse(response.body)['error']).to eq("Apenas o dono do restaurante tem acesso à isso")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      before do
        headers = valid_headers
        @order = create(:order)
        put "http://app.example.com/v1/manager/orders/#{@order.id}", params: valid_update_attributes, headers: headers
      end

      it 'returns status code ok' do
        expect(response).to have_http_status(:ok)
      end

      it 'should return the updated order' do
        expect(JSON.parse(response.body)['order']['quantity']).to eq(5)
      end

    end

    context "with invalid params" do
      before do
        headers = valid_headers
        @order = create(:order)
        put "http://app.example.com/v1/manager/orders/#{@order.id}", params: invalid_update_attributes, headers: headers
      end

      it 'returns status code unprocessable_entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'should return an error message' do
        expect(JSON.parse(response.body)['quantity'][0]).to eq('não pode ficar em branco')
      end

    end

    context "with no user authentitication" do
      before do
        headers = valid_headers
        @order = create(:order)
        put "http://app.example.com/v1/manager/orders/#{@order.id}", params: valid_update_attributes, headers: unauthorized_headers
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(:unauthorized)
      end

      it 'should return an error message' do
        expect(JSON.parse(response.body)['error']).to eq("Apenas o dono do restaurante tem acesso à isso")
      end
    end
  end
end
