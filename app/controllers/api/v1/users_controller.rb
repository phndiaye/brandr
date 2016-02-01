class Api::V1::UsersController < Api::V1::BaseController
  def show
    user = User.find(params[:id])
    respond_with user
  end

  def create
    user = User.new(user_params)
    user.username = SecureRandom.hex(5)
    user.save

    if user.valid?
      render json: user, status: :created
    else
      render json: { errors: user.errors }, status: 201
    end
  end

  def me
    if current_user
      respond_with current_user
    else
      render json: {}, status: 401 unless current_user
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :id, :firstname, :lastname, :email, :password, :password_confirmation,
      :username)
  end
end
