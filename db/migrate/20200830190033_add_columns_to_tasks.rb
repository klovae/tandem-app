class AddColumnsToTasks < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :status, :string, default: "open"
    add_column :tasks, :deadline, :datetime
    add_column :tasks, :completion_date, :datetime
  end
end
