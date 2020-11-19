class ClaimSerializer < ActiveModel::Serializer
  attributes :id, :agent_id, :claimed_ticket_id
end
