class AddSectionToTasks < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :section_id, :integer
  end
end
