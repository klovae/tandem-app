class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :content
      t.date :deadline
      t.belongs_to :project
      t.references :parent

      t.timestamps
    end
  end
end
