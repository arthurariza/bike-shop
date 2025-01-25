require 'rails_helper'

RSpec.describe V1::Admin::ProhibitedCombinationsController, type: :controller do
  let(:customization_item) { create(:customization_item) }
  let(:prohibited_item) { create(:customization_item) }
  let(:prohibited_combination) { create(:prohibited_combination, customization_item: customization_item, prohibited_item: prohibited_item) }
  let(:valid_attributes) { { customization_item_id: customization_item.id, prohibited_item_id: prohibited_item.id } }
  let(:invalid_attributes) { { customization_item_id: customization_item.id, prohibited_item_id: customization_item.id } }

  describe "GET #index" do
    it "returns a success response" do
      get :index

      expect(response).to be_successful
    end

    context 'when customization_item_id param is provided' do
      it 'returns a list of prohibited combinations for the given customization item' do
        customization_item = build(:customization_item)

        allow(CustomizationItem).to receive(:find_by!).and_return(customization_item)
        allow(customization_item).to receive(:prohibited_combinations).and_return([ build(:prohibited_combination) ])

        get :index, params: { customization_item_id: '1' }

        expect(customization_item).to have_received(:prohibited_combinations)
      end

      it 'returns not found when customization item does not exist' do
        get :index, params: { customization_item_id: 0 }

        expect(response).to have_http_status(:not_found)
        expect(response.parsed_body['error']).to eq('Not found')
        expect(response.parsed_body['status']).to eq(404)
      end
    end

    context 'when customization_item_id param is not provided' do
      it 'returns all prohibited combinations' do
        allow(ProhibitedCombination).to receive(:all).and_return([])

        get :index

        expect(ProhibitedCombination).to have_received(:all)
      end
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { id: prohibited_combination.to_param }

      expect(response).to be_successful
    end

    it 'returns not found when prohibited combination does not exist' do
      get :show, params: { id: 0 }

      expect(response).to have_http_status(:not_found)
      expect(response.parsed_body['error']).to eq('Not found')
      expect(response.parsed_body['status']).to eq(404)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new ProhibitedCombination" do
        expect {
          post :create, params: { prohibited_combination: valid_attributes }
        }.to change(ProhibitedCombination, :count).by(1)
      end

      it "renders a JSON response with the new prohibited_combination" do
        post :create, params: { prohibited_combination: valid_attributes }

        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new prohibited_combination" do
        post :create, params: { prohibited_combination: invalid_attributes }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested prohibited_combination" do
      combination = create(:prohibited_combination)

      expect {
        delete :destroy, params: { id: combination.to_param }
      }.to change(ProhibitedCombination, :count).by(-1)
    end

    it 'returns not found when prohibited_combination does not exist' do
      delete :destroy, params: { id: 0 }

      expect(response).to have_http_status(:not_found)
      expect(response.parsed_body['error']).to eq('Not found')
      expect(response.parsed_body['status']).to eq(404)
    end
  end
end
