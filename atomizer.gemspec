# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "atomizer/version"

Gem::Specification.new do |s|
  s.name        = "atomizer"
  s.version     = Atomizer::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Mutwin Kraus"]
  s.email       = ["mutwin.kraus@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Utilities for atom feed parsing and generation}
  s.description = %q{Utilities for atom feed parsing and generation}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "nokogiri"
end
