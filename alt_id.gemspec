lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "alt_id/version"

Gem::Specification.new do |spec|
  spec.name          = "alt_id"
  spec.version       = AltId::VERSION
  spec.authors       = ['booink']
  spec.email         = ['booink.work@gmail.com']

  spec.summary       = %q{alt_id provide obfuscated and url safe id of ActiveRecord with reference transparency. alt_id は難読かつURLセーフなActiveRecordのIDを参照透過的に使えるようにするgemです}
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/booink/alt_id"
  spec.license       = "MIT"
  spec.metadata["homepage_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", "~> 5.2"

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
