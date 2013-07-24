class UserProjectAssignment < ActiveRecord::Base
  attr_accessible :project_id, :role, :user_id
  
  validates :project_id ,:presence=>true
  validates :role ,:presence=>true
  validates :user_id ,:presence=>true
  
  belongs_to:user
  belongs_to:project
  
end
