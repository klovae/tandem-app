class RemoveColumnsFromAssignmnets < ActiveRecord::Migration[6.0]
  def change
    remove_column :assignments, :status
    remove_column :assignments, :deadline
    remove_column :assignments, :completion_date
  end
end
