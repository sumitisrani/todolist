class AddRoleToUserProjectAssignments < ActiveRecord::Migration
  def change
    add_column :user_project_assignments, :role ,:string, :default => "admin"
  end
end
