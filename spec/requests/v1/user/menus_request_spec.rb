require 'rails_helper'

RSpec.describe "V1::User::Menus", type: :request do
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

  describe "GET #index" do
    context "with user signed_in" do
      before do
        headers = valid_headers
        @category = create(:category_with_items)

        get "http://app.example.com/v1/user/menus", params: {}, headers: headers
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:success)
      end

      it 'should return all the menu of the restaurant' do
        expect(JSON.parse(response.body).size).to eq(1) # tem uma categoria so criada
        expect(JSON.parse(response.body)[0]['items'].size).to eq(1) # 1 item criado pra primeira categoria
      end
    end

    context "with user not signed in" do
      before do
        headers = unauthorized_headers
        get "http://app.example.com/v1/user/menus", params: {}, headers: headers
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
