class UserVersion < ActiveRecord::Base
  belongs_to :user
  belongs_to :version
end