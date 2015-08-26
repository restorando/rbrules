class RbRules

  attr_reader :rules

  @rule_sets = Hash.new { |hash, key| hash[key] = new }

  def +(other)
    self.class.new do |builder|
      rules.each { |rule| builder.rule(rule) }
      if other.is_a?(self.class)
        other.rules.each { |rule| builder.rule(rule) }
      else
        builder.rule(other)
      end
    end
  end

  def self.[](key)
    @rule_sets[key]
  end

  def initialize(&block)
    @rules = []
    yield(self) if block_given?
  end

  def rule(name_or_rule, &block)
    if name_or_rule.respond_to? :call
      rules << name_or_rule
    else
      rules << Rule.new(name_or_rule, block)
    end
  end

  %w[all? none?].each do |method_name|
    define_method method_name do |*args|
      rules.public_send(method_name) { |rule| rule.call(*args) }
    end
  end

  def any?(*args)
    rules.find do |rule|
      rule.call(*args)
    end
  end

  class Rule < Struct.new(:name, :block)

    def call(*args); block.call(*args) end

  end
end
