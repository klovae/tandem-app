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

  def all_collaborators
    collaborators = []
    self.permissions.each do |collaborator|
      collaborators << [collaborator.access_level, collaborator.user]
    end
    collaborators
  end


  def human_time
    self.deadline.strftime("%A, %B %-d, %Y")
  end

end
