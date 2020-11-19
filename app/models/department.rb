class Department < ApplicationRecord
	validates :title,presence: true, length: { minimum: 5 }
	has_many :users, dependent: :nullify
	has_many :tickets, dependent:  :nullify
end
