# RbRules

This library simplifies a rule set definition that can later be used to check if they
are satisfied for a given object or to find the rule that a given object doesn't satisfy.

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
MY_HOUSE_MY_RULES = RbRules.new do |rules|
  rules.rule(:smoke) { |age| age > 21 }
  rules.rule(:sleep) { |age| age.even? }
end
```

Test your object

```ruby
MY_HOUSE_MY_RULES.all? 22 # => true
MY_HOUSE_MY_RULES.none? 12 # => false
```

If you don't want to pollute your global namespace to define global rules, you can give
your a name to your rule set like this:

```ruby
RbRules[:salute].rule(:hawaiian) {|string| string =~ /aloha/i }
RbRules[:salute].rule(:english) {|string| string =~ /hello|good bye/i }

RbRules[:salute].any? "Aloha world!"
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

Adding new rules to an existing one

You can add new rules to existing ones using the `ruby + ` operator.

```ruby
new_rule = RbRules.new do |rules|
   rules.rule(:baby) { |age| age < 5 }
end

NEW_HOUSE_RULES = MY_HOUSE_MY_RULES + new_rule

NEW_HOUSE_RULES.all? 19 # => false
NEW_HOUSE_RULES.all? 22 # => false
NEW_HOUSE_RULES.all? 4 # => true
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
