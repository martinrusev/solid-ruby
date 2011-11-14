# -*- encoding: utf-8 -*-
require File.expand_path('../lib/ramon/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = "ramon"
  s.version     = Ramon::VERSION
  s.authors     = ["martinrusev"]
  s.email       = ["martin@amon.cx"]
  s.homepage    = "http://amon.cx"
  s.summary     = %q{Ruby binding for Amon}
  s.description = %q{Amon client for Ruby that provides logging and exception handling for web applications}

  s.rubyforge_project = "ramon"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.add_dependency(%q<json>, [">= 0"])
end
