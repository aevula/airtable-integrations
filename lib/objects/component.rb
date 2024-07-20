# frozen_string_literal: true

class Component
  ACRONYMS = { api: 'API' }
  private_constant :ACRONYMS

  def self.to_s(name)
    new(name).to_s
  end

  attr_reader :before

  def initialize(name)
    @before = name
  end

  def to_s
    parsed
  end

  private

  def parsed
    @parsed ||= before.to_s
                      .split('-')
                      .map { |part| ACRONYMS[part.downcase] ? ACRONYMS[part.downcase] : part.capitalize }
                      .join('-')
  end
end
