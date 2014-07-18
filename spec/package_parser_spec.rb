require 'spec_helper'
require 'package_parser'

describe PackageParser do

  it "should have correct package info as hash" do
    something = Object.new
    PackageParser.stub(:download_zipped_package)
    UnzipService.stub(:unzip)
    PackageParser.stub(:description_from_file).and_return("Package: package_name\nVersion: version_name")

    PackageParser.parse(something).should == {"Package"=>"package_name", "Version" => "version_name"}
  end
end