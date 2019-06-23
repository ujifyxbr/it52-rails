class EventTitleImageUploader < CarrierWave::Uploader::Base
  include UploaderConcern

  def default_url
    ActionController::Base.helpers.asset_path("events_fallback/" + [version_name, "default.png"].compact.join('_'))
  end

  version :square_500 do
    process resize_to_fit: [500, 500]
  end

  version :fb_1200 do
    process resize_to_fill: [1200, 630]
  end
end
