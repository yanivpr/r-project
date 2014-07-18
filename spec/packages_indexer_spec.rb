require 'spec_helper'
require 'packages_indexer'

describe PackagesIndexer do

  it "should call the packages reader" do
    PackagesReader.should_receive(:read)
    PackagesWriter.stub(:store)

    PackagesIndexer.index
  end

  it "should call the packages writer" do
    reader_result = Object.new
    PackagesReader.stub(:read).and_return(reader_result)
    PackagesWriter.should_receive(:store).with(reader_result)

    PackagesIndexer.index
  end

end