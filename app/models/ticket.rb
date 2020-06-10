class Ticket < ApplicationRecord
  before_save :assign_defaults
  PRIORITIES = [:low, :medium, :high].freeze
  STATUSES = [:open, :working, :rejected, :resolved, :closed].freeze

  enum priority: PRIORITIES
  enum status: STATUSES



  belongs_to :department
  belongs_to :user
  has_many :comments

  has_many :claims,foreign_key: :claimed_ticket_id
  has_many :agents,through: :claims,source: :agent

   def assign_defaults
  	#set priority to low if blank
    if priority.blank?
      self.priority = :low
    end
    #set ticket status to open when created
    if new_record? && status.blank?
      self.status = :open
    end
    #update start at to current time
    if status_changed? && status == 'working'
      self.started_at = Time.zone.now
    end
    #update resolved at to current time 
    if status_changed? && status == 'resolved'
      self.resolved_at = Time.zone.now
    end
  end
end
