class CreatePermissions < ActiveRecord::Migration[6.0]
  def change
    create_table :permissions do |t|
      t.string :access_level
      t.belongs_to :project
      t.belongs_to :user
      
      t.timestamps
    end
  end
end
