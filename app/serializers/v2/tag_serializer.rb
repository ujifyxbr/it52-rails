# frozen_string_literal: true

module V2
  class TagSerializer
    include FastJsonapi::ObjectSerializer

    set_key_transform :camel_lower

    attributes :name, :taggings_count
  end
end
