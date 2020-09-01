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

  def self.user_list(current_user)
    dated_tasks = []
    undated_tasks = []
    Assignment.where(user_id: current_user.id).find_each do |assignment|
      if assignment.task.status == "open" 
        if assignment.task.deadline
          dated_tasks << assignment.task
        else
          undated_tasks << assignment.task
        end
      end
    end
    dated_tasks.sort_by { |task| task.deadline if task.deadline }
    dated_tasks + undated_tasks
  end

end
