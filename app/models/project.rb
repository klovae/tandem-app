class Project < ApplicationRecord
  has_many :permissions
  has_many :users, through: :permissions

  def set_owner(current_user)
    Permission.create(project_id: self.id, user_id: current_user.id, access_level: "owner")
  end

  def owners
    owners = []
    self.permissions.where(access_level: "owner").each do |owner|
      owners << owner.user
    end
    owners
  end

  def human_time
    self.deadline.strftime("%A, %B %-d, %Y")
  end
end
