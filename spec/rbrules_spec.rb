require 'minitest/autorun'
require './lib/rbrules'

class TestRbRules < MiniTest::Test

  attr_reader :rb_rules

  def setup
    @rb_rules = RbRules.new do |rules|
      rules.rule(:hello) { |param| param =~ /hello/ }
      rules.rule(:world) { |param| param =~ /world/ }
    end
  end

  def test_number_of_rules
    assert_equal 2, rb_rules.rules.size
  end

  def test_any?
    assert rb_rules.any?('hello')
    assert rb_rules.any?('world')
  end

  def test_any_returns_rule
    assert rb_rules.any?('hello').name == :hello
  end

  def test_all?
    refute rb_rules.all?('hello')
    refute rb_rules.all?('world')
    assert rb_rules.all?('hello world')
  end

  def test_none?
    assert rb_rules.none?('none')
    refute rb_rules.none?('hello')
  end

  def test_sum

    rb_rule_extra = RbRules.new do |rules|
      rules.rule(:extra) { true }
    end

    combined_rules = rb_rules + rb_rule_extra

    assert_equal 3, combined_rules.rules.size
    assert rb_rule_extra.rules.all? { |r| combined_rules.rules.include?(r) }
  end

end

class TestSingleton < TestRbRules

  RbRules[:test].rule(:hello) { |param| param =~ /hello/ }
  RbRules[:test].rule ->(param) { param =~ /world/ }

  def setup
    @rb_rules = RbRules[:test]
  end

end
