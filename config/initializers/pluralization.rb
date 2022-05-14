# frozen_string_literal: true

# rubocop:disable Lint/SendWithMixinArgument
require 'i18n/backend/pluralization'
I18n::Backend::Simple.send(:include, I18n::Backend::Pluralization)
# rubocop:enable Lint/SendWithMixinArgument
