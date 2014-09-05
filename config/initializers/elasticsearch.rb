require 'elasticsearch/model'
require 'elasticsearch/transport'

if ENV['BONSAI_URL']
  Elasticsearch::Model.client = Elasticsearch::Client.new url: ENV['BONSAI_URL']
end
