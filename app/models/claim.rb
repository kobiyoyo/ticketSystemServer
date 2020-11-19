class Claim < ApplicationRecord
	belongs_to :claimed_ticket,class_name: :Ticket
	belongs_to :agent,class_name: :User
end
