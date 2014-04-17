$: << File.dirname(__FILE__)

STDOUT.sync = true

require 'bundler/setup'
Bundler.require(:default)
Dir['./helpers/**/*.rb'].sort.each { |f| require f }

# Ensure the cache dir exists
FileUtils.mkdir_p 'tmp/cache'
FileUtils.rm_rf 'tmp/cache/**'

Flatrack.config do |site|
  site.assets.js_compressor  = :uglify if ENV['RACK_ENV'] == 'production'
  site.assets.css_compressor = :scss if ENV['RACK_ENV'] == 'production'
  site.assets.append_path 'assets/fonts'
  site.assets.append_path Bootstrap.stylesheets_path
  site.assets.append_path Bootstrap.fonts_path
  site.assets.append_path Bootstrap.javascripts_path
  site.assets.append_path 'assets/stylesheets'
end
