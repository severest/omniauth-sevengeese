lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "omniauth-sevengeese/version"

Gem::Specification.new do |gem|
  gem.add_dependency "oauth2",     "~> 1.4"
  gem.add_dependency "omniauth",   "~> 1.9"

  gem.add_development_dependency "bundler", "~> 2.0"

  gem.authors       = ["Sean Everest"]
  gem.description   = "An 7Geese OAuth2 strategy for OmniAuth."
  gem.summary       = gem.description

  gem.name          = "omniauth-sevengeese"
  gem.require_paths = %w[lib]
  gem.version       = OmniAuth::Sevengeese::VERSION
end
