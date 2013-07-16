class UserProjectAssignment < ActiveRecord::Base
  attr_accessible :project_id, :role, :user_id
  
  after_validation :drop_down_value_same_as_selected_by_user
  
 
  
  validates :project_id ,:presence=>true
  validates :role ,:presence=>true
  #validates :user_id ,:presence=>true
  
  belongs_to:user
  belongs_to:project
  
  
  def drop_down_value_same_as_selected_by_user
   
    upa = UserProjectAssignment.where(:project_id => self.project_id).pluck(:user_id)
    user_ids = User.where('id not in (?)',upa).map(&:id)
    unless user_ids.include?(user_id)  
      errors.add(:base,'Invalid user name or user id ')
    end
  end
  
end
