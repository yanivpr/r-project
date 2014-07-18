require 'rubygems/package'
require 'zlib'

class UnzipService

  TAR_LONGLINK = '././@LongLink'

  # Unzip a zip file, and return the directory of the unzipped
  def self.unzip(file_path)
    destination = "#{Rails.root}/downloads"

    unzipped_root_directory = nil

    Gem::Package::TarReader.new( Zlib::GzipReader.open file_path ) do |tar|
      dest = nil

      tar.each do |entry|
        if entry.full_name == TAR_LONGLINK
          dest = File.join destination, entry.read.strip
          next
        end
        dest ||= File.join destination, entry.full_name
        if entry.directory?
          File.delete dest if File.file? dest
          FileUtils.mkdir_p dest, :mode => entry.header.mode, :verbose => false
          unzipped_root_directory ||= dest # HACK! assume it's the first one created
        elsif entry.file?
          FileUtils.rm_rf dest if File.directory? dest
          File.open dest, "wb" do |f|
            f.print entry.read
          end
          FileUtils.chmod entry.header.mode, dest, :verbose => false
        elsif entry.header.typeflag == '2' #Symlink!
          File.symlink entry.header.linkname, dest
        end
        dest = nil
      end
    end

    unzipped_root_directory
  end
end