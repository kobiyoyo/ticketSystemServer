class User < ApplicationRecord
   #Validations
   validates :first_name,presence: true 
   validates :last_name,presence: true 
   VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
   validates :email, presence: true,uniqueness: true, format: { with: VALID_EMAIL_REGEX }
   #encrypt password
   has_secure_password
   validates :password_digest, presence: true, length: { minimum: 6 }
end
