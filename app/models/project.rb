class Project < ActiveRecord::Base
  attr_accessible :description, :end_date, :start_date, :status, :title ,:user_id
  attr_accessor :user_id
  
  validates :description, :presence => true 
  validates :end_date, :presence => true
  validates :start_date, :presence => true 
  validates :status, :presence => true 
  validates :title, :presence => true 
  
  has_many :tasks, :dependent => :destroy 
  has_many :user_project_assignments, :dependent => :destroy  
  has_many :users ,through: :user_project_assignments
  
end
