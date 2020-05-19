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

RSpec.describe "/v1/manager/tables", type: :request do
  # This should return the minimal set of attributes required to create a valid
  # Table. As you add validations to Table, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {number: 1}
  }

  let(:invalid_attributes) {
    {number: nil}
  }

  # This should return the minimal set of values that should be in the headers
  # in order to pass any filters (e.g. authentication) defined in
  # TablesController, or in your router and rack
  # middleware. Be sure to keep this updated too.

  let(:valid_headers) {
    @user_app = User.find_by(email: "app@admin.com")
    @user_app.create_new_auth_token
  }

  describe "GET /index" do
    it "renders a successful response" do
      Table.create! valid_attributes
      get "http://app.example.com/v1/manager/tables", headers: valid_headers
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      table = Table.create! valid_attributes
      get "http://app.example.com/v1/manager/tables/#{table.id}", params: {}, headers: valid_headers
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Table" do
        expect {
          post "http://app.example.com/v1/manager/tables/",
               params: { table: valid_attributes }, headers: valid_headers
        }.to change(Table, :count).by(1)
      end

      it "renders a JSON response with the new table" do
        post "http://app.example.com/v1/manager/tables/",
             params: { table: valid_attributes }, headers: valid_headers
        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid parameters" do
      it "does not create a new Table" do
        expect {
          post "http://app.example.com/v1/manager/tables",
               params: { table: invalid_attributes }
        }.to change(Table, :count).by(0)
      end

      it "renders a JSON response with errors for the new table" do
        post "http://app.example.com/v1/manager/tables/",
             params: { table: invalid_attributes }, headers: valid_headers
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do

      it "updates the requested table" do
        table = Table.create! valid_attributes
        patch "http://app.example.com/v1/manager/tables/#{table.id}",
              params: { table: {number: 3} }, headers: valid_headers
        table.reload
        expect(JSON.parse(response.body)['number']).to eq 3
      end

      it "renders a JSON response with the table" do
        table = Table.create! valid_attributes
        patch "http://app.example.com/v1/manager/tables/#{table.id}",
              params: { table: valid_attributes }, headers: valid_headers
        expect(response).to have_http_status(:ok)
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the table" do
        table = Table.create! valid_attributes
        patch "http://app.example.com/v1/manager/tables/#{table.id}",
              params: { table: invalid_attributes }, headers: valid_headers
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested table" do
      table = Table.create! valid_attributes
      expect {
        delete "http://app.example.com/v1/manager/tables/#{table.id}", headers: valid_headers
      }.to change(Table, :count).by(-1)
    end
  end
end
