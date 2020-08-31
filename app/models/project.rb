class Project < ApplicationRecord
  has_many :permissions
  has_many :users, through: :permissions
  has_many :tasks

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

  def collaborators_with_access_level
    collaborators = []
    self.permissions.each do |c|
      collaborators << [c.user, c.access_level]
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
    self.deadline.strftime("%A, %B %-d, %Y")
  end

end
