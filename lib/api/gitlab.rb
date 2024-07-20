# frozen_string_literal: true

require_relative 'client'

class Gitlab
  extend Client

  def self.merge_request(url:)
    @merge_request ||= client(url:).get.body
  end
end
