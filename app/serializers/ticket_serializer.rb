class TicketSerializer < ActiveModel::Serializer
  attributes :id, :priority, :message, :subject, :status,:started_at,:resolved_at
  has_one :department
  has_one :user
  has_many :agents
end
