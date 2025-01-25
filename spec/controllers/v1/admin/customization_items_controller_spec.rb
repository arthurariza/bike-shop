require 'rails_helper'

RSpec.describe V1::Admin::CustomizationItemsController, type: :controller do
  let(:customization) { create(:customization) }
  let(:customization_item) { create(:customization_item, customization: customization) }
  let(:valid_attributes) { { name: 'New Item', price: '10.99', in_stock: true } }
  let(:invalid_attributes) { { name: '', price: 'invalid' } }

  describe "GET #index" do
    it "returns a success response" do
      get :index, params: { customization_id: customization.id }
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { customization_id: customization.id, id: customization_item.to_param }
      expect(response).to be_successful
    end

    it 'returns not found when customization_item does not exist' do
      get :show, params: { customization_id: customization.id, id: 0 }
      expect(response).to have_http_status(:not_found)
      expect(response.parsed_body['error']).to eq('Not found')
      expect(response.parsed_body['status']).to eq(404)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new CustomizationItem" do
        expect {
          post :create, params: { customization_id: customization.id, customization_item: valid_attributes }
        }.to change(CustomizationItem, :count).by(1)
      end

      it "renders a JSON response with the new customization_item" do
        post :create, params: { customization_id: customization.id, customization_item: valid_attributes }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new customization_item" do
        post :create, params: { customization_id: customization.id, customization_item: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) { { name: 'Updated Item', price: '20.99', in_stock: false } }

      it "updates the requested customization_item" do
        put :update, params: { customization_id: customization.id, id: customization_item.to_param, customization_item: new_attributes }
        customization_item.reload
        expect(customization_item.name).to eq('Updated Item')
        expect(customization_item.price).to eq(BigDecimal('20.99'))
        expect(customization_item.in_stock).to be_falsey
      end

      it "renders a JSON response with the customization_item" do
        put :update, params: { customization_id: customization.id, id: customization_item.to_param, customization_item: valid_attributes }
        expect(response).to be_successful
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the customization_item" do
        put :update, params: { customization_id: customization.id, id: customization_item.to_param, customization_item: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested customization_item" do
      customization_item = create(:customization_item, customization: customization)
      expect {
        delete :destroy, params: { customization_id: customization.id, id: customization_item.to_param }
      }.to change(CustomizationItem, :count).by(-1)
    end

    it 'returns not found when customization_item does not exist' do
      delete :destroy, params: { customization_id: customization.id, id: 0 }
      expect(response).to have_http_status(:not_found)
      expect(response.parsed_body['error']).to eq('Not found')
      expect(response.parsed_body['status']).to eq(404)
    end
  end
end
