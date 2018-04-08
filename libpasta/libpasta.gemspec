# coding: utf-8
require 'rubygems'
require 'rubygems/package_task'

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'libpasta/version'

lib_file = 'lib/pasta.so'

if not File.exist? lib_file or File.zero? lib_file then
  warn "Empty lib/pasta.so file, needs compiling from the SWIG sources first
         Try `rake build_from_source`."
end

Gem::Specification.new do |spec|
  spec.name          = "libpasta"
  spec.version       = Libpasta::VERSION
  spec.authors       = ["Sam Scott"]
  spec.email         = ["sam.scott89@gmail.com"]

  spec.summary       = "Easy-to-use, secure-by-default password hashing library"
  spec.homepage      = "https://libpasta.github.io/"
  spec.license       = "MIT"

  spec.files = %w(.rspec
    .travis.yml
    Gemfile
    LICENSE.txt
    README.md
    Rakefile
    lib/pasta.so
    lib/libpasta.rb
    lib/libpasta/version.rb
    libpasta.gemspec
    spec/libpasta_spec.rb
    spec/spec_helper.rb)
  spec.require_paths = ["lib"]
  spec.extensions    = ["Rakefile"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 12.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
