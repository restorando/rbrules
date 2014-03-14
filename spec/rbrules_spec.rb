require 'minitest/autorun'
require './lib/rbrules'

class TestRbRules < Minitest::Unit::TestCase

  attr_reader :rb_rules

  def setup
    @rb_rules = RbRules.new do
      rule(:hello) { |param| param == 'hello' }
      rule(:world) { |param| param == 'world' }
    end
  end

  def test_any?
    assert rb_rules.any?('hello')
    assert rb_rules.any?('world')
  end

  def test_all?
    refute rb_rules.all?('hello')
    refute rb_rules.all?('world')
  end

  def test_none?
    assert rb_rules.none?('none')
    refute rb_rules.none?('hello')
  end

end

class TestSingleton < Minitest::Unit::TestCase

  attr_reader :rb_rules

  def setup
    RbRules[:test].rule(:hello) { |param| param == 'hello' }
    RbRules[:test].rule(:world) { |param| param == 'world' }
  end

  def test_any?
    assert RbRules[:test].any?('hello')
    assert RbRules[:test].any?('world')
  end

  def test_all?
    refute RbRules[:test].all?('hello')
    refute RbRules[:test].all?('world')
  end

  def test_none?
    assert RbRules[:test].none?('none')
    refute RbRules[:test].none?('hello')
  end

end
