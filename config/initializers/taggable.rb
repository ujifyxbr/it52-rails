# frozen_string_literal: true

class TagsParser < ActsAsTaggableOn::GenericParser
  def parse
    ActsAsTaggableOn::TagList.new.tap do |tag_list|
      tag_list.add @tag_list.split(%r{\,|\s|\||/|\;})
    end
  end
end

ActsAsTaggableOn.default_parser = TagsParser
