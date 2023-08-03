# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vimeo_me2/version'

Gem::Specification.new do |spec|
  spec.name          = "vimeo_me2"
  spec.version       = VimeoMe2::VERSION
  spec.authors       = ["Bo-oz"]
  spec.email         = ["boristoet80@gmail.com"]

  spec.summary       = "Temp"
  spec.description   = "Temp"
  spec.homepage      = "https://github.com/bo-oz/vimeo_me2"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "http://mygemserver.com"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.1.4"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "vcr", "~> 3.0.3"
  spec.add_development_dependency "webmock", "~> 3.0.1"
  spec.add_development_dependency "simplecov", "~> 0.17.1"
  spec.add_development_dependency "byebug"

  spec.add_runtime_dependency "httparty","~> 0.21.0"
end
