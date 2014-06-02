# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "rbrules"
  spec.version       = "0.0.2"
  spec.authors       = ["Gabriel Schammah", "Juan Barreneche"]
  spec.email         = ["devs@restorando.com"]
  spec.homepage      = "http://engineering.restorando.com"
  spec.description   = %q{Declare rule sets to check your objects against them later}
  spec.summary       = <<-SUMMARY
    This library simplifies a rule set definition that can later be used to check if they
    are satisfied for a given object and or find the rule that a given object doesn't
    satisfy.
  SUMMARY
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "minitest"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "pry"
end
