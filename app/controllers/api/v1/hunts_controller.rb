class Api::V1::HuntsController < Api::V1::BaseController
  before_action :doorkeeper_authorize!, only: [:index, :create]

  DEFAULT_PAGE = 1
  DEFAULT_PER_PAGE = 20

  def index
    hunts = Hunt.page(page).per(per_page)
    respond_with hunts, meta: { pages: hunts.total_pages, total: Hunt.count }
  end

  def show
    hunt = Hunt.find(params[:id])
    respond_with hunt
  end

  def create
    hunt = Hunt.new(hunt_params.except(:image, :image_url, :hunt_items))
    hunt.user = current_user
    set_image(hunt)
    hunt.hunt_items.build(hunt_params.fetch(:hunt_items))
    hunt.save

    if hunt.valid?
      render json: hunt, status: :created
    else
      render json: { errors: hunt.errors.details }, status: :unprocessable_entity
    end
  end

  private

  def set_image(hunt)
    if hunt_params.fetch(:image, {}).any?
      hunt.image = ConvertToUpload.perform(hunt_params[:image])
    elsif hunt_params.fetch(:image_url, hunt.image_url) != hunt.image_url
      hunt.remote_image_url = hunt_params[:image_url]
    end
  end

  def page
    params[:page] || DEFAULT_PAGE
  end

  def per_page
    params[:per_page] || DEFAULT_PER_PAGE
  end

  def hunt_params
    params.require(:hunt).permit(
      :image_url,
      :image => [:data, :filename, :size, :type],
      :hunt_items => [:top, :left]
    )
  end
end
