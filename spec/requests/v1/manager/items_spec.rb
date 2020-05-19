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

RSpec.describe "V1::Manager::Items", type: :request do
  MENU_ITEMS_SIZE = 5

  describe "GET #index" do
    before() do
      MENU_ITEMS_SIZE.times do |i|
        create(:item_with_category, price: 5.99 + i, name: "Produto #{i+1}")
      end

      @user_app = User.find_by(email: "app@admin.com")
      headers = @user_app.create_new_auth_token if sign_in(@user_app)
      get "http://app.example.com/v1/manager/items", params: {}, headers: headers
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end

    it 'should return all the menu itens' do
      expect(JSON.parse(response.body).size).to eq(MENU_ITEMS_SIZE)
    end
  end

  describe "GET #show" do
    before() do
      @item = create(:item_with_category, price: 5.99, name: "Litrão Skol")

      @user_app = User.find_by(email: "app@admin.com")
      headers = @user_app.create_new_auth_token if sign_in(@user_app)

      get "http://app.example.com/v1/manager/items/#{@item.id}", params: {}, headers: headers
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end

    it 'should return the menu item requeted' do
      expect(JSON.parse(response.body)['id']).to eq(@item.id)
      expect(JSON.parse(response.body)['name']).to eq(@item.name)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      before() do
        item_params = {item: {name: "Cerveja 600ml", price: 5.90, available: true, quantity: 10}}
        @item_count = Item.count

        @user_app = User.find_by(email: "app@admin.com")
        headers = @user_app.create_new_auth_token if sign_in(@user_app)
        post "http://app.example.com/v1/manager/items/", params: item_params, headers: headers
      end

      it 'returns status code created' do
        expect(response).to have_http_status(:created)
      end

      it 'should return the menu item created' do
        expect(JSON.parse(response.body)['name']).to eq('Cerveja 600ml')
        expect(JSON.parse(response.body)['price']).to eq(5.90)
      end

      it 'should create an item in the DB' do
        expect(Item.count).to eq @item_count + 1
      end
    end

    context "with invalid params" do
      before() do
        item_params = {item: {name: nil, price: 5.90, available: true, quantity: 10}}
        @item_count = Item.count

        @user_app = User.find_by(email: "app@admin.com")
        headers = @user_app.create_new_auth_token if sign_in(@user_app)
        post "http://app.example.com/v1/manager/items/", params: item_params, headers: headers
      end

      it 'returns status code unprocessable_entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'should return an error message' do
        expect(JSON.parse(response.body)['name'][0]).to eq('não pode ficar em branco')
      end

      it 'should not create an item in the DB' do
        expect(Item.count).to eq @item_count
      end
    end
  end

  describe "PUT #update" do

    context "with valid params" do
      before() do
        @item = create(:item_with_category, price: 5.99, name: "Litrão Skol")
        item_params = {item: {name: "Cerveja 300ml", price: 4.90, available: true, quantity: 9}}

        @user_app = User.find_by(email: "app@admin.com")
        headers = @user_app.create_new_auth_token if sign_in(@user_app)
        put "http://app.example.com/v1/manager/items/#{@item.id}", params: item_params, headers: headers
      end

      it 'returns status code updated' do
        expect(response).to have_http_status(200)
      end

      it 'should update the menu item and show it' do
        expect(JSON.parse(response.body)['name']).to eq('Cerveja 300ml')
        expect(JSON.parse(response.body)['price']).to eq(4.90)
      end
    end

    context "with invalid params" do
      before() do
        @item = create(:item_with_category, price: 5.99, name: "Litrão Skol")
        item_params = {item: {name: nil, price: 4.80, available: true, quantity: 9}}
        @item_count = Item.count

        @user_app = User.find_by(email: "app@admin.com")
        headers = @user_app.create_new_auth_token if sign_in(@user_app)
        put "http://app.example.com/v1/manager/items/#{@item.id}", params: item_params, headers: headers
      end

      it 'returns status code unprocessable_entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'should return an error message' do
        expect(JSON.parse(response.body)['name'][0]).to eq('não pode ficar em branco')
      end

      it 'should not create an item in the DB' do
        expect(Item.count).to eq @item_count
      end

    end
  end

  describe "DELETE #destroy" do
    before() do
      @item = create(:item_with_category, price: 5.99, name: "Litrão Skol")
      @item_2 = create(:item_with_category, price: 6.99, name: "Litrão Antartica")
      @item_count = Item.count

      @user_app = User.find_by(email: "app@admin.com")
      headers = @user_app.create_new_auth_token if sign_in(@user_app)
      delete "http://app.example.com/v1/manager/items/#{@item.id}", params: {}, headers: headers
    end

    it 'returns status code deleted' do
      expect(response).to have_http_status(204)
    end

    it 'should delete the item' do
      expect(Item.count).to eq @item_count - 1
    end

  end

end