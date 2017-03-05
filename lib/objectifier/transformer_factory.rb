require "objectifier/result"

module Objectifier
  class TransformerFactory
    def initialize
      @t = Hash.new { |h,k| raise "unknown type #{@type}" }

      @t[:boolean] = lambda do |name, value|
        case value
        when true, 'true', 1, '1'
          ValueResult.new(name, true)
        when false, 'false', 0, '0'
          ValueResult.new(name, false)
        else
          ErrorResult.err(name, 'not boolean')
        end
      end

      @t[:symbol] = ->(name, value) { ValueResult.new(name, value.to_sym) }

      @t[:string] = ->(name, value) { ValueResult.new(name, value.to_s) }

      @t[:integer] = lambda do |name, value|
        begin
          ValueResult.new(name, Integer(value))
        rescue => e
          ErrorResult.err(name, e.message)
        end
      end

      @t[:fixnum] = @t[:integer]

      @t[:bignum] = @t[:integer]

      @t[:float] = lambda do |name, value|
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
