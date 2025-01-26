require 'rails_helper'

RSpec.describe V1::ProductsController, type: :controller do
  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end

    it "returns products ordered by category name and product name" do
      mock_products = double("Products")
      allow(Product).to receive(:includes).with(:category).and_return(mock_products)
      allow(mock_products).to receive(:order).with("categories.name ASC", name: :asc).and_return(mock_products)

      get :index

      expect(mock_products).to have_received(:order).with("categories.name ASC", name: :asc)
    end
  end

  describe "GET #show" do
    let(:category) { create(:category) }
    let(:product) { create(:product, category: category) }

    it "returns a success response" do
      get :show, params: { id: product.to_param }

      expect(response).to be_successful
    end

    it "includes category and customizations in the response" do
      customization = create(:customization, category: category)
      create(:customization_item, customization: customization)

      get :show, params: { id: product.to_param }

      json_response = response.parsed_body
      expect(json_response["category"]).to be_present
      expect(json_response["customizations"]).to be_present
      expect(json_response["customizations"].first["items"]).to be_present
    end

    it 'returns not found when product does not exist' do
      get :show, params: { id: 0 }

      expect(response).to have_http_status(:not_found)
      expect(response.parsed_body['status']).to eq(404)
      expect(response.parsed_body['error']).to eq('Not found')
      expect(response.parsed_body['message']).to match(/Couldn't find Product/)
    end
  end
end
