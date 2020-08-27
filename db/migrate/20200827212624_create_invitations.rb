class CreateInvitations < ActiveRecord::Migration[6.0]
  def change
    create_table :invitations do |t|
      t.integer :sender_id
      t.integer :invited_id
      t.string :message
      t.string :access_level
      t.string :status
      t.timestamps
    end
  end
end
