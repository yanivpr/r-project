require 'open-uri'
require 'package_parser'

class PackagesReader

  PACKAGES_FILE_NAME = 'PACKAGES'
  PACKAGES_FILE_EXTENSION = 'gz'
  PACKAGES_FILE_URL = 'http://cran.r-project.org/src/contrib/PACKAGES'
  LIMIT_FOR_DEMO = 30

  def self.read
    puts "Downloading packages index file"
    download_packages_file

    puts "extracting pairs form file"
    package_version_pairs = extract_package_version_pairs_from_packages_index_file[0..LIMIT_FOR_DEMO-1]

    puts "reading each package to a hash"
    read_packages_info(package_version_pairs)
  end

  private

  def self.read_packages_info(package_version_pairs)
    package_infos = []

    puts "Reading #{package_version_pairs.size} package infos"

    package_version_pairs.each_with_index do |package_version_pair, index|
      puts "#{index+1}) #{package_version_pair[0]} - #{package_version_pair[1]}"
      package_infos << PackageParser.parse(package_version_pair)
    end

    package_infos
  end

  def self.zipped_file_name
    "#{Rails.root}/#{PACKAGES_FILE_NAME}.#{PACKAGES_FILE_EXTENSION}"
  end

  def self.download_packages_file
    open(zipped_file_name, 'wb') do |file|
      file << open(PACKAGES_FILE_URL).read
    end
  end

  def self.extract_package_version_pairs_from_packages_index_file
    content = read_file_content

    content.scan(/Package: ([^\s]*)[\s]*Version: ([^\s]*)/)
  end

  def self.read_file_content
    content = nil

    File.open(zipped_file_name, "rb") do |gz|
      content = gz.read
    end

    content
  end

end

