class Comment < ActiveRecord::Base
  attr_accessible :message, :task_id, :user_id
  
  validates :message, :presence => true
  validates :task_id, :presence => true
  validates :user_id, :presence => true
  
  belongs_to:task 
  belongs_to:user 
end
