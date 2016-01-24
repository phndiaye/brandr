class Api::V1::BaseController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  protect_from_forgery with: :null_session

  respond_to :json

  def not_found
    render json: 'entity not found', status: :not_found
  end

  def current_user
    if doorkeeper_token
      @current_user ||= User.find(doorkeeper_token.resource_owner_id)
    end
  end

  def doorkeeper_unauthorized_render_options
    { json: { 'error' => 'Unauthorized Access' } }
  end
end
