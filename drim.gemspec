
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "drim/version"

Gem::Specification.new do |spec|
  spec.name          = "drim"
  spec.version       = Drim::VERSION
  spec.authors       = ["Bree Newfile"]
  spec.email         = ["bree@memework.org"]

  spec.summary       = %q{Discord relay in Minecraft}
  spec.description   = %q{Vanilla discord relay client using trickery.}
  spec.homepage      = "https://memework.org/"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against " \
  #     "public gem pushes."
  # end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "bin"
  spec.executables   = []
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_runtime_dependency 'zrcon', '~> 0.0.4'
end
