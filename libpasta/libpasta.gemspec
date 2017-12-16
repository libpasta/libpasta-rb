# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'libpasta/version'

Gem::Specification.new do |spec|
  spec.name          = "libpasta"
  spec.version       = Libpasta::VERSION
  spec.authors       = ["Sam Scott"]
  spec.email         = ["sam.scott89@gmail.com"]

  spec.summary       = "Easy-to-use, secure-by-default password hashing library"
  # spec.description   = %q{TODO: Write a longer description or delete this line.}
  spec.homepage      = "https://libpasta.github.io/"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against " \
  #     "public gem pushes."
  # end


  spec.files = `git ls-files`.split("\n")


  # get an array of submodule dirs by executing 'pwd' inside each submodule
  gem_dir = File.expand_path(File.dirname(__FILE__)) + "/"
  `git submodule --quiet foreach --recursive pwd`.split($\).each do |submodule_path|
    Dir.chdir(submodule_path) do
      submodule_relative_path = submodule_path.sub gem_dir, ""
      # issue git ls-files in submodule's directory and
      # prepend the submodule path to create absolute file paths
      `git ls-files`.split($\).each do |filename|
        spec.files << "#{submodule_relative_path}/#{filename}"
      end
    end
  end

  spec.require_paths = ["lib"]
  spec.extensions    = ["Rakefile", 'ext/Rakefile']

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rake-compiler"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_runtime_dependency 'thermite', '~> 0'
end
