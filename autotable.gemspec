$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "autotable/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "autotable"
  s.version     = Autotable::VERSION
  s.authors     = ["Jason Frame"]
  s.email       = ["jason@onehackoranother.com"]
  s.homepage    = "https://github.com/jaz303/autotable"
  s.summary     = "Rails plugin to auto-generate Bootstrap-compliant HTML tables from model collections"
  s.description = ""

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  #s.add_dependency "rails", "~> 4.0.2"

  s.add_development_dependency "sqlite3"
end
