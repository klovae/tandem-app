class Assignment < ApplicationRecord
  belongs_to :user
  belongs_to :task

  def self.user_list(current_user)
    dated_tasks = []
    undated_tasks = []
    where(user_id: current_user.id).find_each do |assignment|
      if assignment.task.status == "open" 
        if assignment.task.deadline
          dated_tasks << assignment.task
        else
          undated_tasks << assignment.task
        end
      end
    end
    dated_tasks.sort_by { |task| task.deadline }
    dated_tasks + undated_tasks
  end
end