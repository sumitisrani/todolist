class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :address, :email, :gender, :image, :name, :password, :phone
  
    validates :address, :presence => true
    
    validates :name, :presence => true ,length: { in: 6..20 }
    
    validates :phone, :presence => true ,:length=>{:is=>10}  , numericality: { only_integer: true }
    validates :gender ,:presence=>true       
  
  has_many:tasks
  has_many:user_project_assignments
  has_many:projects ,through: :user_project_assignments
  has_many:comments
end

  
