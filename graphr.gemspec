require_relative 'lib/graphr/version'

Gem::Specification.new do |spec|
  spec.name          = "graphr"
  spec.version       = Graphr::VERSION
  spec.authors       = ["Adrian Vasile"]
  spec.email         = ["adivasile07@gmail.com"]

  spec.summary       = %q{Graph implementation and algorithms}
  spec.description   = %q{{Graph implementation and algorithms}}
  spec.homepage      = "https://graphsrcool.com"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.1.2"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.2"
  spec.add_development_dependency "guard", "~> 2.16.1"
  spec.add_development_dependency "guard-rspec", "~> 4.7.3"
  spec.add_development_dependency "simplecov", "~> 0.18.2"

  spec.add_dependency 'activesupport', '~> 6.0.0'
  spec.add_dependency 'ruby-graphviz', '~> 1.2.4'
end
