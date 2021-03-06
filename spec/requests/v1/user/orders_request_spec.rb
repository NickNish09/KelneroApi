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
  # commandsController, or in your router and rack
  # middleware. Be sure to keep this updated too.
  let(:valid_headers) {
    @user = create(:user)
    @user.create_new_auth_token
  }

  let(:unauthorized_headers) {
    {}
  }

  USER_COMMANDS = 5

  describe "GET #index" do
    context "with user signed_in" do
      before do
        headers = valid_headers
        USER_COMMANDS.times do |i|
          create(:command, user: @user)
        end
        get "http://app.example.com/v1/user/orders", params: {}, headers: headers
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:success)
      end

      it 'should return all the user commands' do
        expect(JSON.parse(response.body).size).to eq(USER_COMMANDS)
      end
    end

    context "with user not signed in" do
      before do
        headers = valid_headers
        USER_COMMANDS.times do |i|
          create(:command, user: @user)
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

  describe "POST #create" do
    context "with valid params" do
      before do
        headers = valid_headers
        @command = create(:command, user: @user)
        @command_orders = @command.items.count
        post "http://app.example.com/v1/user/orders/", params: valid_attributes, headers: headers
      end

      it 'returns status code created' do
        expect(response).to have_http_status(:created)
      end

      it 'should return the command with the new items in the command' do
        expect(JSON.parse(response.body)['orders'].size).to eq(1)
      end

      it 'should create an item in the DB' do
        expect(@command.items.count).to eq @command_orders + 1
      end
    end

    context "with invalid params" do
      before do
        headers = valid_headers
        @command = create(:command, user: @user)
        @command_orders = @command.items.count
        post "http://app.example.com/v1/user/orders/", params: invalid_attributes, headers: headers
      end

      it 'returns status code unprocessable_entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'should return an error message' do
        expect(JSON.parse(response.body)['error']).to eq('Um dos pedidos não pode ser criado')
      end

      it 'should not create an item in the DB' do
        expect(@command.items.count).to eq @command_orders
      end
    end

    context "with no user authentitication" do
      before do
        headers = valid_headers
        @command = create(:command, user: @user)
        post "http://app.example.com/v1/user/orders/", params: valid_attributes, headers: unauthorized_headers
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
