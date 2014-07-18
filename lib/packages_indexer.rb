require 'open-uri'
require 'packages_reader'
require 'packages_writer'

class PackagesIndexer
  def self.index
    packages_info = PackagesReader.read
    PackagesWriter.store(packages_info)
  end
end

