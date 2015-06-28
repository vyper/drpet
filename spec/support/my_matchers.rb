require 'rspec/expectations'

module MyMatchers
  def allow_value(value)
    AllowValueMatcher.new(value)
  end

  class AllowValueMatcher
    def initialize(value)
      @value = value
    end

    def matches?(target)
      @target = target
      @target.send("#{@attribute}=", @value)
      @target.valid?

      !(@target.errors.for(@attribute).select { |error| error.attribute == @attribute.to_s && error.validation == :format }.size > 0)
    end

    def description
      # TODO Sets description
      'description'
    end

    def failure_message
      "invalid format of '#{@value}' for '#{@attribute}'"
    end

    def failure_message_when_negated
      "not invalid format of '#{@value}' for '#{@attribute}'"
    end

    def for(attribute)
      @attribute = attribute
      self
    end
  end

  def validate_presence_of(attribute)
    ValidatePresenceMatcher.new(attribute)
  end

  class ValidatePresenceMatcher
    def initialize(attribute)
      @attribute = attribute
    end

    def matches?(target)
      @target = target
      @target.valid?

      @target.errors.for(@attribute).select { |error| error.attribute == @attribute.to_s && error.validation == :presence }.size > 0
    end

    def description
      # TODO Sets description
      'description'
    end

    def failure_message
      "expected #{@target.inspect} <> #{@expected}"
    end

    def failure_message_when_negated
      "expected #{@target.inspect} not <> #{@expected}"
    end
  end
end
