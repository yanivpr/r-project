require 'spec_helper'
require 'packages_reader'

describe PackagesReader do

  it "should extract package-version pairs for 1 package" do
    content = "Package: abc\nVersion: 1.0\n"
    PackagesReader.stub(:read_file_content).and_return(content)
    pairs = PackagesReader.extract_package_version_pairs_from_packages_index_file

    pairs.should =~ [['abc', '1.0']]
  end

  it "should extract package-version pairs for 2 packages" do
    content = "Package: abc\nVersion: 1.0\nPackage: def\nVersion: 2.0\n"
    PackagesReader.stub(:read_file_content).and_return(content)
    pairs = PackagesReader.extract_package_version_pairs_from_packages_index_file

    pairs.should =~ [['abc', '1.0'], ['def', '2.0']]
  end

end