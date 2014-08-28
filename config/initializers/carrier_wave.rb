CarrierWave.configure do |config|
  config.storage    = :aws
  config.aws_bucket = Figaro.env.aws_bucket
  config.aws_acl    = :public_read
  config.asset_host = Figaro.env.aws_host
  config.aws_authenticated_url_expiration = 60 * 60 * 24 * 365

  config.aws_credentials = {
    access_key_id:     Figaro.env.aws_access_key_id,
    secret_access_key: Figaro.env.aws_secret_access_key
  }

  config.cache_dir = "#{Rails.root}/tmp/uploads"
end
