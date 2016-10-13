require "objectifier/result"

module Objectifier
  class MapValue
    attr_reader :rules

    def initialize(scope = "", &block)
      @scope = scope.to_s
      @rules = Hash.new
      instance_eval &block
    end

    def name
      @scope
    end

    def required?
      @rules.values.reduce(false) do |req, rule|
        req || rule.required?
      end
    end

    def item(name, **args)
      @rules[name.to_s] = ScalarValue.new(name, args)
      true
    end

    def items(name, **args)
      @rules[name.to_s] = ArrayValue.new(name, args)
      true
    end

    def map(name, &block)
      @rules[name.to_s] = MapValue.new(name, &block)
      true
    end

    def pp(indent = "")
      next_indent = "#{indent}  "
      str = "#{indent} #{@scope} {\n"
      str << @rules.values.map { |r| r.pp(next_indent) }.join("\n")
      str << "\n#{indent}}\n"
      str
    end

    def to_s
      pp("")
    end

    # examine parameters and return a hash of massaged data or an error results
    def call(parameters)

      if @scope.length > 0
        parameters = parameters.fetch(
          @scope,
          parameters.fetch(
            @scope.to_s,
            {}))
      end

      ok, errors = @rules.values.map do |rule|
        rule.call(parameters)
      end.partition do |result|
        result.success?
      end

      if errors.empty?
        values = ok.select(&:value?)

        if values.empty?
          SuccessResult.new(@scope)
        else
          ValueResult.new(
            @scope,
            Hash[values.map { |v| [ v.name, v.value ] }])
        end
      else
        errors.reduce(ErrorResult.new) { |total, err| total.merge(err) }.scope(@scope)
      end
    end
  end
end
