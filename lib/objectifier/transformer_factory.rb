require "objectifier/result"

module Objectifier
  class TransformerFactory
    def initialize
      @t = Hash.new { |h,k| raise "unknown type #{@type}" }
      @t[String] = ->(name, value) { ValueResult.new(name, value.to_s) }
      @t[Integer] = ->(name, value) {
        begin
          ValueResult.new(name, Integer(value))
        rescue => e
          ErrorResult.err(name, e.message)
        end
      }
      @t[Float] = ->(name, value) { ValueResult.new(name, value.to_f) }
    end

    def add_type(type, transformer)
      @t[type] = transformer
    end

    def for_type(type)
      @t[type]
    end
  end
end
