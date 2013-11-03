$LOAD_PATH << File.dirname(__FILE__)

require 'bundler/setup'
Bundler.require(:default)
STDOUT.sync                     = true
Haml::Options.defaults[:format] = :html5

require 'app/flat_site'

require 'sass/plugin/rack'
use Sass::Plugin::Rack
use Rack::Static, urls: ["/favicon.ico", "/stylesheets", "/images"], root: "public"
run FlatSite