# RbRules

This library simplifies a rule set definition that can later be used to check if they
are satisfied for a given object and or find the rule that a given object doesn't satisfy.

## Installation

Add this line to your application's Gemfile:

    gem 'rbrules'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rbrules

## Usage

Define your ruleset:

```ruby
@my_house_my_rules = RbRules.new do |rules|
  rules.rule(:hello) { |param| param =~ /hello/ }
  rules.rule(:world) { |param| param =~ /world/ }
end
```

Test your object

```ruby
@my_house_my_rules.all? "hello world" # => true
@my_house_my_rules.none? "good bye cruel world!" # => false
```

You can also define your custom rules (which should respond to `#call(obj)`) in case
you need to take different actions when different rules fail

For example:

```ruby
class MagicNumber < Struct.new(:magic_number)

  def call(obj)
    magic_number == obj
  end

end

RbRules[:random_rules].rule MagicNumber.new(3)

matching_rule = RbRules[:random_rules].any?(3)
matching_rule.magic_number # => 3
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
