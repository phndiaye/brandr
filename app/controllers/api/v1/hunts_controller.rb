class Api::V1::HuntsController < Api::V1::BaseController
  def index
    hunts = Hunt.all
    respond_with hunts
  end
end
