$LOAD_PATH << File.dirname(__FILE__)

STDOUT.sync = true

require 'bundler/setup'
Bundler.require(:default)

Dir['./helpers/**/*.rb'].sort.each { |f| require f }
