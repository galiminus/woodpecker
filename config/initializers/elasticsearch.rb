require 'elasticsearch/model'
require 'elasticsearch/transport'

if ENV['ELASTICSEARCH_URL']
  Elasticsearch::Model.client = Elasticsearch::Client.new url: ENV['ELASTICSEARCH_URL']
end
