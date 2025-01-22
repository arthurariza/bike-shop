require 'rails_helper'

RSpec.describe V1::Admin::CategoriesController, type: :controller do
  let!(:category) { create(:category) }
  let(:valid_attributes) { { name: 'New Category' } }
  let(:invalid_attributes) { { name: '' } }

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { id: category.to_param }
      expect(response).to be_successful
    end

    it 'returns not found when category does not exist' do
      delete :show, params: { id: 0 }
      expect(response).to have_http_status(:not_found)
      expect(response.parsed_body['error']).to eq('Not found')
      expect(response.parsed_body['status']).to eq(404)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Category" do
        expect {
          post :create, params: { category: valid_attributes }
        }.to change(Category, :count).by(1)
      end

      it "renders a JSON response with the new category" do
        post :create, params: { category: valid_attributes }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new category" do
        post :create, params: { category: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) { { name: 'Updated Category' } }

      it "updates the requested category" do
        put :update, params: { id: category.to_param, category: new_attributes }
        category.reload
        expect(category.name).to eq('Updated Category')
      end

      it "renders a JSON response with the category" do
        put :update, params: { id: category.to_param, category: valid_attributes }
        expect(response).to be_successful
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the category" do
        put :update, params: { id: category.to_param, category: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end

      it 'returns not found when category does not exist' do
        delete :update, params: { id: 0 }
        expect(response).to have_http_status(:not_found)
        expect(response.parsed_body['error']).to eq('Not found')
        expect(response.parsed_body['status']).to eq(404)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested category" do
      expect {
        delete :destroy, params: { id: category.to_param }
      }.to change(Category, :count).by(-1)
    end

    it 'returns not found when category does not exist' do
      delete :destroy, params: { id: 0 }
      expect(response).to have_http_status(:not_found)
      expect(response.parsed_body['error']).to eq('Not found')
      expect(response.parsed_body['status']).to eq(404)
    end
  end
end
