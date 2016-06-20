CarrierWave.configure do |config|
  config.cache_dir        = "#{Rails.root}/tmp/uploads"
  config.storage          = :fog
  config.fog_directory    = Figaro.env.aws_bucket
  config.fog_credentials  = {
    provider:               'AWS',
    aws_access_key_id:      Figaro.env.aws_access_key_id,
    aws_secret_access_key:  Figaro.env.aws_secret_access_key,
    region:                 Figaro.env.fog_region,
    host:                   Figaro.env.fog_host
  }

  config.asset_host = Figaro.env.aws_host
end
