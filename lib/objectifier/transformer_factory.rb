require "objectifier/result"

module Objectifier
  class TransformerFactory
    def initialize
      @t = Hash.new { |h,k| raise "unknown type #{@type}" }

      @t[Symbol] = ->(name, value) { ValueResult.new(name, value.to_sym) }

      @t[String] = ->(name, value) { ValueResult.new(name, value.to_s) }

      @t[Integer] = ->(name, value) do
        begin
          ValueResult.new(name, Integer(value))
        rescue => e
          ErrorResult.err(name, e.message)
        end
      end

      @t[Fixnum] = @t[Integer]

      @t[Bignum] = @t[Integer]

      @t[Float] = ->(name, value) do
        begin
          ValueResult.new(name, Float(value))
        rescue => e
          ErrorResult.err(name, e.message)
        end
      end
    end

    def add_type(type, transformer)
      @t[type] = transformer
    end

    def for_type(type)
      @t[type]
    end
  end
end
