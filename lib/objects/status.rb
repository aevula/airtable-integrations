# frozen_string_literal: true

class Status
  STATUSES = {
    created:   'Created',
    reviewing: 'On Review',
    assigned:  'Assigned',
    merged:    'Merged',
    blocked:   'Blocked',
    closed:    'Closed'
  }
  private_constant :STATUSES

  attr_reader :mr

  def self.to_s(mr)
    new(mr).to_s
  end

  def initialize(mr)
    @mr = mr
  end

  def to_s
    parsed
  end

  private

  def parsed
    @parsed ||= begin
      key = :merged if mr.merged?
      key ||= :closed if mr.closed?
      key ||= :blocked if mr.blocked?
      key ||= :created if !mr.reviewer && (!mr.assignee || mr.assignee == mr.creator)
      key ||= :reviewing if mr.reviewer
      key ||= :assigned if mr.assignee

      STATUSES[key]
    end
  end
end
