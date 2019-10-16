require 'rubygems'
require 'bundler'

Bundler.require

require './test_api'

run Sinatra::Application
