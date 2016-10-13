require "objectifier/version"
require "objectifier/result"
require "objectifier/scalar_value"
require "objectifier/array_value"
require "objectifier/map_value"
require "objectifier/transformer_factory"

module Objectifier
  def self.factories
    @factories ||= TransformerFactory.new
  end

  def self.define(&block)
    MapValue.new("",&block)
  end
end
