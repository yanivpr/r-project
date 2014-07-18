class User < ActiveRecord::Base
  has_many :user_versions

  has_many :versions, through: :user_versions

  def to_s
    "#{name} <#{email}>"
  end
end