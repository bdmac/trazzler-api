# -*- encoding: utf-8 -*-
require File.expand_path("../lib/trazzler-api/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "trazzler-api"
  s.version     = TrazzlerApi::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Brian McManus"]
  s.email       = []
  s.homepage    = "http://api.trazzler.com"
  s.summary     = %q{The Trazzler API exposes RESTful interfaces for accessing trip page and user data.}
  s.description = %q{The Trazzler API exposes RESTful interfaces for accessing trip page and user data.}

  s.rubyforge_project = "trazzler-api"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.required_rubygems_version = ">= 1.3.6"
  
  s.add_development_dependency "bundler", ">= 1.0.0"
  s.add_development_dependency "rspec", "~> 2.0.1"
  
  s.add_runtime_dependency "httparty", "~> 0.5.2"
  s.add_runtime_dependency "json", "~> 1.4.3"
  s.add_runtime_dependency "hashie", "~> 0.2.0"
end
