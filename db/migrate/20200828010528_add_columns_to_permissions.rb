class AddColumnsToPermissions < ActiveRecord::Migration[6.0]
  def change
    add_column :permissions, :creator_id, :integer
    add_column :permissions, :accepted, :boolean, default: false
  end
end
