#!/usr/bin/env ruby
require 'pp'
require 'minitest/autorun'

Dir.chdir(File.dirname __FILE__)
$:.unshift 'lib',*Dir["vendor/*/lib"]

require 'w4n/filter'
require 'w4n/test'
require 'w4n/metric'
require 'w4n/machine'

Dir['./tests/*.rb'].each do |x|
  require x
end
