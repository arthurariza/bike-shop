class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def record_not_found(exception)
    render json: { status: 404, error: "Not found", message: exception.message }, status: :not_found
  end
end
