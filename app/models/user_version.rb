class UserVersion < ActiveRecord::Base
  belongs_to :user
  belongs_to :version

  #belongs_to :author, class_name: User.name
  #belongs_to :maintainer, class_name: User.name

end