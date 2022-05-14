# frozen_string_literal: true

module Telegram
  class Channel
    def self.groups
      @groups ||= YAML.load_file(Rails.root.join('config', 'telegram_channels.yml')).deep_symbolize_keys[:groups]
    end
  end
end
