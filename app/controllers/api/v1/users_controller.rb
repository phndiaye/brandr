class Api::V1::UsersController < Api::V1::BaseController
  def show
    user = User.find(params[:id])
    respond_with user
  end

  def me
    if current_user
      respond_with current_user
    else
      render json: {}, status: 401 unless current_user
    end
  end

  private

  def users_params
    params.require(:user).permit(:id)
  end
end
