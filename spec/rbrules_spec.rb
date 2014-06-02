require 'minitest/autorun'
require './lib/rbrules'

class TestRbRules < MiniTest::Unit::TestCase

  attr_reader :rb_rules

  def setup
    @rb_rules = RbRules.new do |rules|
      rules.rule(:hello) { |param| param =~ /hello/ }
      rules.rule(:world) { |param| param =~ /world/ }
    end
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

end

class TestSingleton < TestRbRules

  def setup
    rb_rules.rule(:hello) { |param| param =~ /hello/ }
    rb_rules.rule ->(param) { param =~ /world/ }
  end

  def rb_rules
    RbRules[:test]
  end

end
