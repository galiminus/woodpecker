require 'elasticsearch/model'

class Image < ActiveRecord::Base
  include Elasticsearch::Model

  has_attachment  :file, accept: [:jpg, :png, :gif]

  settings :index do
    mappings do
      indexes tags:            { type: 'string', analyzer: 'keyword'   }
    end
  end

  def as_indexed_json(options={})
    as_json(except: [:id]).tap do |resource|
      resource[:url] = Cloudinary::Utils.cloudinary_url(file.path, width: 870, crop: :limit)
      resource[:thumbnail] = Cloudinary::Utils.cloudinary_url(file.path, height: 160, crop: :fit)
    end
  end
end
