require 'spec_helper'
require 'packages_writer'

describe PackagesWriter do

  context "store_package" do

    it "should add a package" do
      hash = {
          "Package" => 'name',
          "Title" => "title",
          "Date/Publication" => Time.now,
          "Description" => "descr"
      }

      expect {
        PackagesWriter.store_package(hash)
      }.to change(Package, :count).by(1)

    end

    it "should not add a duplicate package" do
      hash = {
          "Package" => 'name',
          "Title" => "title",
          "Date/Publication" => Time.now,
          "Description" => "descr"
      }

      PackagesWriter.store_package(hash)

      expect {
        PackagesWriter.store_package(hash)
      }.to_not change(Package, :count)

    end

  end
end