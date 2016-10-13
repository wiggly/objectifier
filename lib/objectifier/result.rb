module Objectifier
  class SuccessResult
    attr_reader :name

    def initialize(name)
      @name = name
    end

    def success?
      true
    end

    def value?
      false
    end
  end

  class ValueResult < SuccessResult
    attr_reader :value

    def initialize(name, value)
      super(name)
      @value = value
    end

    def value?
      true
    end
  end

  class ErrorResult < Hash
    def initialize
      super
    end

    def self.err(name, value)
      new.tap do |x|
        x[name] = value
      end
    end

    def scope(name)
      reduce(self.class.new) do |h, kvp|
        k, v = kvp
        h[name.to_s+"."+k.to_s] = v
        h
      end
    end

    def success?
      false
    end

    def value?
      false
    end
  end
end
