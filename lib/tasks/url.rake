require 'fetcher/fetchers/url'

namespace :url do
  task :fetch, [:root] => :environment do |t, args|
    args.with_defaults(:root => "http://www.saawinternational.org/HarpSeal09.jpg")

    Fetcher::Url.fetch!(args.root)
    Image.import
  end
end
