class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  ROLE = ["Member", "Owner"]

  validates :user, :presence => true
  validates_uniqueness_of :user, scope: :project, message: 'has already been added to this project'
end
