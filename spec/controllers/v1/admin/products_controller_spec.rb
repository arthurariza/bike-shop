require 'rails_helper'

RSpec.describe V1::Admin::ProductsController, type: :controller do
  let(:category) { create(:category) }
  let(:product) { create(:product, category: category) }
  let(:valid_attributes) { { name: 'New Product', in_stock: true, price: 100 } }
  let(:invalid_attributes) { { name: '', in_stock: true, price: 100 } }

  describe "GET #index" do
    it "returns a success response" do
      get :index, params: { category_id: category.id }

      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { category_id: category.id, id: product.to_param }

      expect(response).to be_successful
    end

    it 'returns not found when product does not exist' do
      get :show, params: { category_id: category.id, id: 0 }

      expect(response).to have_http_status(:not_found)
      expect(response.parsed_body['error']).to eq('Not found')
      expect(response.parsed_body['status']).to eq(404)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Product" do
        expect {
          post :create, params: { category_id: category.id, product: valid_attributes }
        }.to change(Product, :count).by(1)
      end

      it "renders a JSON response with the new product" do
        post :create, params: { category_id: category.id, product: valid_attributes }

        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new product" do
        post :create, params: { category_id: category.id, product: invalid_attributes }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe "PUT #update" do
    let(:new_attributes) { { name: 'Updated Product', in_stock: false, price: 150 } }

    context "with valid params" do
      it "updates the requested product" do
        put :update, params: { category_id: category.id, id: product.id, product: new_attributes }

        product.reload
        expect(product.name).to eq('Updated Product')
        expect(product.in_stock).to be_falsey
        expect(product.price).to eq(150)
      end

      it "renders a JSON response with the product" do
        put :update, params: { category_id: category.id, id: product.to_param, product: valid_attributes }

        expect(response).to be_successful
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the product" do
        put :update, params: { category_id: category.id, id: product.to_param, product: invalid_attributes }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end

      it 'returns not found when product does not exist' do
        put :update, params: { category_id: category.id, id: 0, product: new_attributes }

        expect(response).to have_http_status(:not_found)
        expect(response.parsed_body['error']).to eq('Not found')
        expect(response.parsed_body['status']).to eq(404)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested product" do
      product = create(:product)

      expect {
        delete :destroy, params: { category_id: product.category.id, id: product.to_param }
      }.to change(Product, :count).by(-1)
    end

    it 'returns not found when product does not exist' do
      delete :destroy, params: { category_id: category.id, id: 0 }

      expect(response).to have_http_status(:not_found)
      expect(response.parsed_body['error']).to eq('Not found')
      expect(response.parsed_body['status']).to eq(404)
    end
  end
end
