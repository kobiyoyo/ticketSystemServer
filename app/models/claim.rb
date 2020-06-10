class Claim < ApplicationRecord
	validates :agent_id,uniqueness: true
	belongs_to :claimed_ticket,class_name: :Ticket
	belongs_to :agent,class_name: :User
end
