# -*- encoding: utf-8 -*-
require File.expand_path('../lib/wtails/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Naoyuki HIRAYAMA"]
  gem.email         = ["naoyuki.hirayama@gmail.com"]
  gem.description   = "Webserver acts like 'tails -f'"
  gem.summary       = "wtails ..."
  gem.homepage      = "https://github.com/jonigata/wtails"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "wtails"
  gem.require_paths = ["lib"]
  gem.version       = Wtails::VERSION

  gem.add_dependency "eventmachine"
  gem.add_dependency "websocket-eventmachine-server"
  gem.add_dependency "eventmachine-tail"
  gem.add_dependency "thin"
  gem.add_dependency "sinatra"
  gem.add_dependency "trollop"
  gem.add_dependency "launchy", ">= 2.0.6"
end
