# frozen_string_literal: true

require_relative 'client'
require 'pp'

class Airtable
  extend Client

  def self.send_webhook(url:, data:)
    pp '*' * 100
    pp url.inspect
    pp '*' * 100
    pp ENV.inspect
    pp '*' * 100
    client(url:).post(nil, data)
  end
end
