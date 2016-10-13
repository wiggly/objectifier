require "objectifier/result"

module Objectifier
  class ArrayValue
    attr_reader :name, :type

    def initialize(name, **args)
      raise ArgumentError, "name required" if name.nil?
      raise ArgumentError, "type required" unless args[:type]

      @name = name.to_s
      @type = args[:type]
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
        SuccessResult.new(@name)
      end
    end

    def pp(indent = "")
      "#{indent} #{to_s}"
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
      return ErrorResult.err(@name, "items must be Array type") unless value.kind_of? Array


      # TODO return result type
      result = value.map { |element| Objectifier.factories.for_type(@type).call(@name, element) }

      values, errors = result.partition do |v|
        v.success?
      end

      if errors.empty?
        xr = values.map do |v|
          v.value
        end

        ValueResult.new(@scope, xr)
      else
        errors.reduce(ErrorResult.new) { |total, err| total.merge(err) }.scope(@scope)
      end
    end

    def to_s
      "array %s - type: %s - required: %s" % [ @name, @type.to_s, @required.to_s ]
    end
  end
end
