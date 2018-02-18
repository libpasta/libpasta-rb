$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "pasta_rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "pasta_rails"
  s.version     = PastaRails::VERSION
  s.authors     = ["Sam Scott"]
  s.email       = ["sam.scott89@gmail.com"]
  s.homepage    = "https://libpasta.github.io"
  s.summary     = "Strong defaults, easy-to-use password hashing tools"
  # s.description = "TODO: Description of PastaRails."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "5.1.2"
  s.add_dependency "libpasta", "~> 0.1.0-rc0"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "bcrypt"

end
