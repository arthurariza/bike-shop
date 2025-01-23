require 'rails_helper'

RSpec.describe V1::Admin::CustomizationsController, type: :controller do
  let(:category) { create(:category) }
  let(:customization) { create(:customization, category: category) }
  let(:valid_attributes) { { name: 'New Customization' } }
  let(:invalid_attributes) { { name: '' } }

  describe "GET #index" do
    it "returns a success response" do
      get :index, params: { category_id: category.id }
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { category_id: category.id, id: customization.to_param }
      expect(response).to be_successful
    end

    it 'returns not found when customization does not exist' do
      get :show, params: { category_id: category.id, id: 0 }
      expect(response).to have_http_status(:not_found)
      expect(response.parsed_body['error']).to eq('Not found')
      expect(response.parsed_body['status']).to eq(404)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Customization" do
        expect {
          post :create, params: { category_id: category.id, customization: valid_attributes }
        }.to change(Customization, :count).by(1)
      end

      it "renders a JSON response with the new customization" do
        post :create, params: { category_id: category.id, customization: valid_attributes }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new customization" do
        post :create, params: { category_id: category.id, customization: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) { { name: 'Updated Customization' } }

      it "updates the requested customization" do
        put :update, params: { category_id: category.id, id: customization.to_param, customization: new_attributes }
        customization.reload
        expect(customization.name).to eq('Updated Customization')
      end

      it "renders a JSON response with the customization" do
        put :update, params: { category_id: category.id, id: customization.to_param, customization: valid_attributes }
        expect(response).to be_successful
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the customization" do
        put :update, params: { category_id: category.id, id: customization.to_param, customization: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested customization" do
      customization = create(:customization, category: category)
      expect {
        delete :destroy, params: { category_id: category.id, id: customization.to_param }
      }.to change(Customization, :count).by(-1)
    end

    it 'returns not found when customization does not exist' do
      delete :destroy, params: { category_id: category.id, id: 0 }
      expect(response).to have_http_status(:not_found)
      expect(response.parsed_body['error']).to eq('Not found')
      expect(response.parsed_body['status']).to eq(404)
    end
  end
end
