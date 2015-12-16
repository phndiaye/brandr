if Rails.env.development?
  CarrierWave.configure do |config|
    config.asset_host = "http://localhost:3000"
  end
end
