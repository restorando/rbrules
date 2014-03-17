class RbRules

  attr_reader :rules

  @rule_sets = Hash.new { |hash, key| hash[key] = new }

  def self.[](key)
    @rule_sets[key]
  end

  def initialize(&block)
    @rules = []
    yield(self) if block_given?
  end

  def rule(name, &block)
    rules << Rule.new(name, block)
  end

  %w[any? all? none?].each do |method_name|
    define_method method_name do |*args|
      rules.public_send(method_name) { |rule| rule.assert(*args) }
    end
  end

  class Rule < Struct.new(:name, :block)

    def assert(*args); block.call(*args) end

  end
end
