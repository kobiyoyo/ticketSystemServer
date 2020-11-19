class User < ApplicationRecord
   ROLES = [:customer, :agent, :admin].freeze

 
   enum role: ROLES

   after_initialize :set_default_role, :if => :new_record?

   #Validations
   validates :first_name,presence: true 
   validates :last_name,presence: true 
   validates :role, presence: true
   VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
   validates :email, presence: true,uniqueness: true, format: { with: VALID_EMAIL_REGEX }
   belongs_to :department
   has_many :comments
   has_many :tickets

   has_many :claims,foreign_key: :agent_id
   has_many :claimed_tickets,through: :claims,source: :claimed_ticket
   
   #encrypt password
   has_secure_password
   validates :password_digest, presence: true, length: { minimum: 6 }


#set new user role to customer
   def set_default_role
   	self.role ||= :customer
   end


 

end
