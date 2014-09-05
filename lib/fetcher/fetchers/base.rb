module Fetcher
  class Base

    TAGS_DELIMITER = /[ _\-\/\+]/
    BLACKLIST = ["src", "pic", "thumbnail", "the", "with", "and", "or", "all"]
    EXTENSIONS = [".gif", ".jpg", ".jpeg", ".tiff", ".png", ".bmp"]

    def Base.extract_tags(tag_elements)
      tags = []
      tag_elements.flatten.each do |tag_element|
        raw_tags = tag_element.split(TAGS_DELIMITER)

        raw_tags.map! do |tag|
          tag.downcase!
          EXTENSIONS.each do |ext|
            tag.gsub!(ext, '')
          end

          tag = '' if (tag.size >= 20)
          tag.gsub!(/^[a-z0-9]{32}$/i, '')
          tag.gsub!(/[^a-z]/i, '')

          tag.parameterize
        end

        raw_tags.select! do |tag|
          tag.size > 2 and tag.size < 20 and !tag.match(/[0-9]+/) and
            !BLACKLIST.include?(tag)
        end

        tags += raw_tags
      end
      tags.uniq
    end
  end
end
