class HomeController < ApplicationController
  def index
    version = if Brandr.redis.exists("brandr-web:index:#{params[:index_key]}")
                "brandr-web:index:#{params[:index_key]}"
              else
                'brandr-web:index:current-content'
              end

    render text: Brandr.redis.get(version), layout: false
  end
end
