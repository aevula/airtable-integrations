# frozen_string_literal: true

require_relative 'api/airtable'
require_relative 'objects/merge_request'
require_relative 'objects/component'
require_relative 'objects/status'

class AirtableIntegrations
  TASK_PREFIX = '.*Dedski-\d+'
  private_constant :TASK_PREFIX

  def self.call(mr_url: nil, webhook_url: nil)
    new(mr_url:).call(webhook_url:)
  end

  attr_reader :mr_url, :webhook_url, :mr

  def initialize(mr_url: nil)
    @mr = MergeRequest.new(url: mr_url || ENV.fetch('MERGE_REQUEST_URL'))
  end

  def call(webhook_url: nil)
    Airtable.send_webhook(
      url: webhook_url || ENV.fetch('AIRTABLE_CREATE_UPDATE_MR_WEBHOOK'),
      data: { task:, merge_request: }
    )
  end

  private

  def task
    mr.title.match(TASK_PREFIX).to_s
  end

  def merge_request
    {
      title:    mr.title,
      number:   mr.number,
      url:      mr.url,
      creator:  mr.creator,
      assignee: mr.assignee,
      reviewer: mr.reviewer,
      component:,
      status:
    }
  end

  def component
    Component.to_s(mr.component)
  end

  def status
    Status.to_s(mr)
  end
end
