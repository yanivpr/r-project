require 'packages_indexer'

namespace :import do

  desc "Import packages data"
  task :packages => :environment do |t, args|
    import_packages

    puts "Finished importing packages"
  end

  def import_packages
    PackagesIndexer.index
  end
end