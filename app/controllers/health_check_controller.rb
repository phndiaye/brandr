class HealthCheckController < ApplicationController
  def index
    render text: "ok\n"
  end
end
