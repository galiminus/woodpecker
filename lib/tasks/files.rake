require 'fetcher/fetchers/files'

namespace :files do
  task :fetch, [:root] => :environment do |t, args|
    args.with_defaults(:root => "~/Pictures/")

    Fetcher::Files.fetch!(args.root)
    Image.import
  end
end
