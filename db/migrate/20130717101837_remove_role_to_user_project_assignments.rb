class RemoveRoleToUserProjectAssignments < ActiveRecord::Migration
  def up
    remove_column :user_project_assignments, :role
  end

  def down
    add_column :user_project_assignments, :role, :string
  end
end
