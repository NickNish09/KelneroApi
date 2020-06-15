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

RSpec.describe "/v1/manager/waiters", type: :request do
  # This should return the minimal set of attributes required to create a valid
  # Waiter. As you add validations to Waiter, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {waiter: {name: "Idiosmar Pereira"}}
  }

  let(:invalid_attributes) {
    {waiter: {name: nil}}
  }

  # This should return the minimal set of values that should be in the headers
  # in order to pass any filters (e.g. authentication) defined in
  # CategoriesController, or in your router and rack
  # middleware. Be sure to keep this updated too.
  let(:valid_headers) {
    @user_app = User.find_by(email: "app@admin.com")
    headers = @user_app.create_new_auth_token
    headers["Subdomain"] = 'app'
    headers
  }

  let(:unauthorized_headers) {
    @user_unauthorized = create(:user)
    headers = @user_unauthorized.create_new_auth_token
    headers["Subdomain"] = 'app'
    headers
  }

  WAITERS_SIZE = 3

  describe "GET #index" do
    context "with permissions" do
      before do
        WAITERS_SIZE.times do |i|
          create(:waiter)
        end
        get "http://app.example.com/v1/manager/waiters", params: {}, headers: valid_headers
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:success)
      end

      it 'should return all the restaurant waiters' do
        expect(JSON.parse(response.body).size).to eq(WAITERS_SIZE)
      end
    end
  end

  describe "GET #show" do
    context "with permissions" do
      before do
        @waiter = create(:waiter)

        get "http://app.example.com/v1/manager/waiters/#{@waiter.id}", params: {}, headers: valid_headers
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:success)
      end

      it 'should return the restaurant waiters' do
        expect(JSON.parse(response.body)['id']).to eq(@waiter.id)
      end
    end

    context "without permissions" do
      before do
        @waiter = create(:waiter)

        get "http://app.example.com/v1/manager/waiters/#{@waiter.id}", params: {}, headers: unauthorized_headers
      end

      it 'returns status code unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end

      it 'should return an error message' do
        expect(JSON.parse(response.body)['error']).to eq('Apenas o dono do restaurante tem acesso à isso')
      end
    end
  end

  describe "POST #create" do
    context "with valid params" do
      before do
        @waiter_count = Waiter.count
        post "http://app.example.com/v1/manager/waiters/", params: valid_attributes, headers: valid_headers
      end

      it 'returns status code created' do
        expect(response).to have_http_status(:created)
      end

      it 'should return the waiters created' do
        expect(JSON.parse(response.body)['name']).to eq("Idiosmar Pereira")
      end

      it 'should create an waiters in the DB' do
        expect(Waiter.count).to eq @waiter_count + 1
      end
    end

    context "with invalid params" do
      before do
        @waiter_count = Waiter.count
        post "http://app.example.com/v1/manager/waiters/", params: invalid_attributes, headers: valid_headers
      end

      it 'returns status code unprocessable_entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'should return an error message' do
        expect(JSON.parse(response.body)['name'][0]).to eq('não pode ficar em branco')
      end

      it 'should not create an waiters in the DB' do
        expect(Waiter.count).to eq @waiter_count
      end
    end
  end

  describe "PUT #update" do
    context "with authorized user" do
      context "with valid params" do
        before do
          @waiter = create(:waiter)
          put "http://app.example.com/v1/manager/waiters/#{@waiter.id}", params: valid_attributes, headers: valid_headers
        end

        it 'returns status code updated' do
          expect(response).to have_http_status(200)
        end

        it 'should update the waiters and show it' do
          expect(JSON.parse(response.body)['name']).to eq("Idiosmar Pereira")
        end
      end

      context "with invalid params" do
        before do
          @waiter = create(:waiter)
          @waiter_count = Waiter.count
          put "http://app.example.com/v1/manager/waiters/#{@waiter.id}", params: invalid_attributes, headers: valid_headers
        end

        it 'returns status code unprocessable_entity' do
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'should return an error message' do
          expect(JSON.parse(response.body)['name'][0]).to eq('não pode ficar em branco')
        end

        it 'should not create an waiters in the DB' do
          expect(Waiter.count).to eq @waiter_count
        end

      end
    end

    context "with unauthorized user" do
      before do
        @waiter = create(:waiter)
        put "http://app.example.com/v1/manager/waiters/#{@waiter.id}", params: valid_attributes, headers: unauthorized_headers
      end

      it 'returns status code unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end

      it 'should return an error message' do
        expect(JSON.parse(response.body)['error']).to eq('Apenas o dono do restaurante tem acesso à isso')
      end

    end
  end

  describe "DELETE #destroy" do
    context "with user authorized" do
      before do
        @waiter = create(:waiter)
        @waiter_count = Waiter.count
        delete "http://app.example.com/v1/manager/waiters/#{@waiter.id}", params: {}, headers: valid_headers
      end

      it 'returns status code deleted' do
        expect(response).to have_http_status(204)
      end

      it 'should delete the waiters' do
        expect(Waiter.count).to eq @waiter_count - 1
      end
    end

    context "with user unauthorized" do
      before do
        @waiter = create(:waiter)
        @waiter_count = Waiter.count
        delete "http://app.example.com/v1/manager/waiters/#{@waiter.id}", params: {}, headers: unauthorized_headers
      end

      it 'returns status code unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end

      it 'should not delete the waiters' do
        expect(Waiter.count).to eq @waiter_count
      end
    end

  end
end
