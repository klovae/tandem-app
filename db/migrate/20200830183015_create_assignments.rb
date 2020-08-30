class CreateAssignments < ActiveRecord::Migration[6.0]
  def change
    create_table :assignments do |t|
      t.references :user
      t.references :task
      t.string :status
      t.datetime :deadline
      t.datetime :completion_date
      t.timestamps
    end
  end
end
