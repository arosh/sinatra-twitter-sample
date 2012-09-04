require 'bundler'
Bundler.require

require File.expand_path('app.rb', File.dirname(__FILE__))
require File.expand_path('model.rb', File.dirname(__FILE__))

run Sinatra::Application
