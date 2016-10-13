require "objectifier/result"

module Objectifier
  class ScalarValue
    attr_reader :name, :type

    def initialize(name, **args)
      raise ArgumentError, "name required" if name.nil?
      raise ArgumentError, "type required" unless args[:type]
      @name = name.to_s
      @type = args[:type] # TODO: check type is valid?
      @required = args.fetch(:required, true)
    end

    def required?
      @required
    end

    def call(parameters)
      if @required && !key_present(parameters)
        ErrorResult.err(@name, "required field missing")
      elsif key_present(parameters)
        transform(key_value(parameters))
      else
        # TODO: this is not a failure...
        SuccessResult.new(@name)
      end
    end

    def pp(indent = "")
      "#{indent} #{to_s}"
    end

    def to_s
      "scalar %s - type: %s - required: %s" % [ @name, @type.to_s, @required.to_s ]
    end

    protected

    def key_present(parameters)
      parameters.has_key?(@name)
    end

    def key_value(parameters)
      parameters.fetch(
        @name,
        parameters[@name]
      )
    end

    def transform(value)
      Objectifier.factories.for_type(@type).call(@name, value)
    end

  end
end
