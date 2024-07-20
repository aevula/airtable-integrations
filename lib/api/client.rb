# frozen_string_literal: true

require 'faraday'

module Client
  def client(url:)
    Faraday.new(url, request: { timeout: 10 }) do |adapter|
      adapter.request(:json)
      adapter.response(:json, parser_options: { symbolize_names: true })
      adapter.response(:raise_error, include_request: true)
      adapter.response :logger, nil, { headers: true, bodies: true, errors: true }
    end
  end
end
