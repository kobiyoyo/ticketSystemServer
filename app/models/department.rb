class Department < ApplicationRecord
	validates :title,presence: true
	has_many :users, dependent: :nullify
	has_many :tickets, dependent:  :nullify
end
