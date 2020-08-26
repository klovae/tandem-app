class Task < ApplicationRecord
  belongs_to :project

  #self join
  has_many :subtasks, class_name: "Task", foreign_key: "parent_id"
  belongs_to :parent, class_name: "Task", optional: true

end
