# frozen_string_literal: true

require 'rails_helper'

describe V1::Admin::CustomizationItemStocksController, type: :controller do
  describe "PUT #update" do
    let(:customization_item) { create(:customization_item, in_stock: true) }

    it "updates the stock of a customization item" do
      put :update, params: { id: customization_item.id, in_stock: false }

      expect(response).to be_successful
      expect(customization_item.reload.in_stock).to be_falsey
    end

    it "returns not found when the customization item does not exist" do
      put :update, params: { id: 0, in_stock: false }

      expect(response).to have_http_status(:not_found)
      expect(response.parsed_body['error']).to eq('Not found')
      expect(response.parsed_body['status']).to eq(404)
    end
  end
end
