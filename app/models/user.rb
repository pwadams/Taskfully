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

  def is_owner?(project)
    self.memberships.where(project_id: project.id).where(role: "Owner").present?

    end


  def is_member?(project)
    self.memberships.where(project_id: project.id).where(role: "Member").present?
  end
end
