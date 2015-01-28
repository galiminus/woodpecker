require 'fetcher/fetchers/url'

namespace :url do
  task :fetch, [:url] => :environment do |t, args|
    args.with_defaults(:url => "http://www.saawinternational.org/HarpSeal09.jpg")

    Fetcher::Url.fetch!(args.url)
    Image.import
  end
end
