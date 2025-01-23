class V1::Admin::CategoriesController < ApplicationController
  before_action :set_category, only: %i[ show update destroy ]

  def index
    @categories = Category.all

    render json: @categories, each_serializer: V1::Admin::CategorySerializer
  end

  def show
    render json: @category, serializer: V1::Admin::CategorySerializer
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      render json: @category, status: :created, serializer: V1::Admin::CategorySerializer
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  def update
    if @category.update(category_params)
      render json: @category, serializer: V1::Admin::CategorySerializer
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @category.destroy!
  end

  private
    def set_category
      @category = Category.find(params.expect(:id))
    end

    def category_params
      params.expect(category: [ :name ])
    end
end
