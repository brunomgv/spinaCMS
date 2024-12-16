module Spina
  module SpinaHelper
    # Override the helper to avoid calling importmap-rails
    def spina_importmap_tags
      # Return an empty string as importmap is not used
      "".html_safe
    end
  end
end