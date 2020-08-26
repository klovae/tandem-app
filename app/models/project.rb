class Project < ApplicationRecord
  has_many :permissions
  has_many :users, through: :permissions

  def set_owner(current_user)
    Permission.create(project_id: self.id, user_id: current_user.id, access_level: "owner")
  end
end
