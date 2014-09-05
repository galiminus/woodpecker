require 'fetcher/fetchers/base'

module Fetcher
  class Files < Base
    def Files.fetch!(root)
      Dir.glob("#{root}/**/*").each do |file|
        next unless EXTENSIONS.include?(File.extname(file))

        begin
          unless Image.find_by_origin(file).present?
            image = Image.new
            image.file = File.open(file)
            image.origin = file
            image.tags = extract_tags([file.gsub(root, "")])
            image.save!
          end
        rescue => error # catch all errors here
          puts error
        end
      end
    end
  end
end
