class Task < ApplicationRecord
  validates :content, presence: true

  belongs_to :project
  has_one :assignment

  #self join
  has_many :subtasks, class_name: "Task", foreign_key: "parent_id"
  belongs_to :parent, class_name: "Task", optional: true

  def human_time
    self.deadline.strftime("%A, %B %-d, %Y")
  end
end
