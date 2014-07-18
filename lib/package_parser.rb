require 'dcf'
require "httparty"
require 'unzip_service'

class PackageParser

  # return hash representing a package-version
  def self.parse(package_version_pair)
    zipped_file_path = download_zipped_package(package_version_pair)
    description_file_path = "#{UnzipService.unzip(zipped_file_path)}DESCRIPTION"

    description = description_from_file(description_file_path)
    Dcf.parse(description).first
  end

  def self.description_from_file(description_file_path)
    content = nil

    File.open(description_file_path, 'rb') do |f|
      content = f.read
    end

    content
  end

  def self.download_zipped_package(package_version_pair)
    url = "http://cran.r-project.org/src/contrib/#{package_version_pair[0]}_#{package_version_pair[1]}.tar.gz"
    zipped_file_path = "#{Rails.root}/#{package_version_pair[0]}_#{package_version_pair[1]}"

    File.open(zipped_file_path, "wb+") do |f|
      f.write HTTParty.get(url).parsed_response
    end

    zipped_file_path
  end
end

