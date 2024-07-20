# frozen_string_literal: true

require_relative 'client'

class Airtable
  extend Client

  def self.send_webhook(url:, data:)
    client(url:).post(nil, data)
  end
end
