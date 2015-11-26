class Api::V1::UsersController < Api::V1::BaseController
  def show
    user = User.find(params[:id])
    respond_with user
  end

  def me
    respond_with current_user
  end

  private

  def users_params
    params.require(:user).permit(:id)
  end
end
