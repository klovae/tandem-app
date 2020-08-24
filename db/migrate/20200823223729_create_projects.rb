class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.string :description
      t.date :deadline

      t.timestamps
    end
  end
end
