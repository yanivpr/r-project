class Version < ActiveRecord::Base
  belongs_to :package

  has_many :user_versions
  has_many :users, through: :user_versions

  #  has_many :maintainers, through: :user_versions, source: :user, source_type: 'Maintainer'
  #has_many :authors, through: :user_versions, source: :user, source_type: 'Author'


end