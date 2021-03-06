class Project < ApplicationRecord
  has_many :permissions, dependent: :destroy
  has_many :users, through: :permissions
  has_many :tasks, dependent: :destroy
  has_many :sections, dependent: :destroy

  validates :title, presence: true
  
  def set_owner(current_user)
    Permission.create(project_id: self.id, user_id: current_user.id, creator_id: current_user.id, access_level: "owner", accepted: true)
  end

  def owners
    owners = []
    self.permissions.where(access_level: "owner").each do |owner|
      owners << owner.user
    end
    owners
  end

  def managers_plus
    managers_plus = []
    self.permissions.where(access_level: "owner").or(self.permissions.where(access_level: "manager")).each do |plus|
      managers_plus << plus.user
    end
    managers_plus
  end

  def verify_owner(user)
    self.owners.include?(user)
  end

  def collaborators_with_access_level
    collaborators = []
    self.permissions.each do |c|
      collaborators << [c.user, c.access_level, c]
    end
    collaborators
  end

  def collaborators
    collaborators = []
    self.permissions.each do |c|
      collaborators << c.user
    end
    collaborators
  end

  def human_time
    if self.deadline
     self.deadline.strftime("%a, %B %-d, %Y")
    end
  end

end
