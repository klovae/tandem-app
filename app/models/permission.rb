class Permission < ApplicationRecord
  belongs_to :user
  belongs_to :project
  belongs_to :creator, class_name: "User"

  validates :access_level, presence: true 
  
end
