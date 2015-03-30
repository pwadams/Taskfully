class User < ActiveRecord::Base
  has_many :memberships, dependent: :destroy
  has_many :comments, dependent: :nullify
  has_many :projects, through: :memberships

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  has_secure_password

  def full_name
    "#{first_name} #{last_name}"
  end

  def is_member?(project)
    self.memberships.find_by(project_id: project.id).present? || self.admin
  end

  def is_owner?(project)
    self.memberships.find_by(project_id: project.id, role: "Owner").present? || self.admin
  end

  def pivotal
    unless pivotal_token == nil
    "#{pivotal_token[0..3]}****************************"
    end
  end
end
