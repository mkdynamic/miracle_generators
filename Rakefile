require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('miracle_generators', '0.1.0') do |p|
  p.description    = "Just another RESTful scaffold generator for Rails."
  p.url            = "http://github.com/mkdynamic/miracle_generators"
  p.author         = 'Mark Dodwell'
  p.email          = "apps (at) mkdynamic (dot) co (dot) uk"
  p.development_dependencies = []
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }
