class V1::Admin::ProhibitedCombinationsController < ApplicationController
  def index
    @prohibited_combinations = if params[:customization_item_id].present?
      CustomizationItem.find_by!(id: params[:customization_item_id]).prohibited_combinations
    else
      ProhibitedCombination.all
    end

    render json: @prohibited_combinations, each_serializer: V1::Admin::ProhibitedCombinationSerializer
  end

  def show
    @prohibited_combination = ProhibitedCombination.find(params[:id])

    render json: @prohibited_combination, serializer: V1::Admin::ProhibitedCombinationSerializer
  end

  def create
    @prohibited_combination = ProhibitedCombination.new(prohibited_combination_params)

    if @prohibited_combination.save
      render json: @prohibited_combination, status: :created, serializer: V1::Admin::ProhibitedCombinationSerializer
    else
      render json: @prohibited_combination.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @prohibited_combination = ProhibitedCombination.find(params[:id])

    @prohibited_combination.destroy!
  end

  private

  def prohibited_combination_params
    params.expect(prohibited_combination: [ :customization_item_id, :prohibited_item_id ])
  end
end
