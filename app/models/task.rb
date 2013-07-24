class Task < ActiveRecord::Base
  attr_accessible :description, :end_date, :project_id, :start_date, :status, :title, :user_id
  
  validates :description, :presence => true 
  validates :end_date, :presence => true
  validates :start_date, :presence => true 
  validates :status, :presence => true 
  validates :title, :presence => true ,:uniqueness => true
  validates :user_id, :presence => true 
  validates :project_id, :presence => true 
     
  
   
  belongs_to :user 
  belongs_to :project 
  has_many :comments, :dependent => :destroy 
  

   def a_method_used_for_validation_purposes
    errors.add(:title, "you cannot create the same task again")
  end
end
