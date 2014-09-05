require 'fetcher/fetchers/base'
require 'uri'

module Fetcher
  class Url < Base
    def Url.fetch!(url)
      unless Image.find_by_origin(url).present?
        image = Image.new
        image.file_url = url
        image.origin = url
        image.tags = extract_tags([URI.parse(url).path])
        image.save!
      end
    end
  end
end
