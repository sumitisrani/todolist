class Project < ActiveRecord::Base
  attr_accessible :description, :end_date, :start_date, :status, :title ,:user_id
  attr_accessor :user_id
  
  
  
  validates :description, :presence => true 
  validates :end_date, :presence => true
  validates :start_date, :presence => true 
  validates :status, :presence => true 
  validates :title, :presence => true 
  
  has_many:tasks 
  has_many:user_project_assignments 
  has_many:users ,through: :user_project_assignments
  
  after_create :assign_admin_role
  
  def assign_admin_role
    UserProjectAssignment.create(:user_id=>self.user_id,:project_id=>self.id,:role=>"admin")
  end


end
