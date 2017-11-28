# coding: utf-8

$:.push File.expand_path("../lib", __FILE__)

require 'ruby_us/version'

Gem::Specification.new do |s|
  s.name          = "ruby_us"
  s.version       = RubyUs::VERSION
  s.authors       = ["rplaurindo"]
  s.email         = ["rafaelplaurindo@gmail.com"]

  s.homepage    = "https://rubygems.org/gems/ruby_us"
  s.summary     = %q{Summary of RubyUs}
  s.description = %q{OO Abstractions and helpers for Ruby.}
  s.license     = "MIT"
  s.test_files  = Dir["test/**/*"]

  s.files = Dir["{config,lib,vendor}/**/*", "MIT-LICENSE", "Rakefile", "README.md", "ruby_us.gemspec"]
  s.require_paths = %w{config lib vendor}
end
