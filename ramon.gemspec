# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "ramon/version"

Gem::Specification.new do |s|
  s.name        = "ramon"
  s.version     = Ramon::VERSION
  s.authors     = ["martinrusev"]
  s.email       = ["martinrusev@zoho.com"]
  s.homepage    = "http://amon.cx"
  s.summary     = %q{Ruby binding for Amon}
  s.description = %q{Amon client that provides logging and exception handling}

  s.rubyforge_project = "ramon"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
