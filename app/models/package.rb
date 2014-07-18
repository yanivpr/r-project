class Package < ActiveRecord::Base
  has_many :versions

  def self.by_free_text(free_text)
    return Package.unscoped unless free_text

    where("name like '%#{free_text}%'")
  end
end