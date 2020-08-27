class AddProjectIdToInvitations < ActiveRecord::Migration[6.0]
  def change
    add_column :invitations, :project_id, :integer
  end
end
