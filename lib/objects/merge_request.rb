# frozen_string_literal: true

require_relative '../api/gitlab'

class MergeRequest
  attr_reader :data

  def initialize(url:)
    @data = Gitlab.merge_request(url:)
  end

  def state
    data[:state]
  end

  def open?
    state == 'open'
  end

  def closed?
    state == 'closed'
  end

  def blocked?
    data[:locked]
  end

  def merged?
    data[:merged]
  end

  def title
    data[:title]
  end

  def number
    data[:number]
  end

  def url
    data[:html_url]
  end

  def component
    data.dig(:head, :repo, :name)
  end

  def creator
    data.dig(:user, :login)
  end

  def assignee
    data.dig(:assignee, :login)
  end

  def reviewer
    return unless data[:requested_reviewers].first

    data[:requested_reviewers].first[:login]
  end
end
