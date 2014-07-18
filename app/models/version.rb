class Version < ActiveRecord::Base
  belongs_to :package

  has_many :user_versions
  has_many :users, through: :user_versions

end