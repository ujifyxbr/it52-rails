class UserAvatarUploader < CarrierWave::Uploader::Base
  include UploaderConcern

  def default_url
    ActionController::Base.helpers.asset_path("avatars_fallback/" + [version_name, "default.png"].compact.join('_'))
  end

  version :square_25 do
    process resize_to_fill: [25,25]
  end

  version :square_50 do
    process resize_to_fill: [50, 50]
  end

  version :square_150 do
    process resize_to_fill: [150, 150]
  end
end
