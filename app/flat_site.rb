module FlatSite
  extend self

  RendererNotFound = Class.new(StandardError)
  FileNotFound = Class.new StandardError

  autoload :Renderers, 'app/renderers'
  autoload :Request, 'app/request'
  autoload :Response, 'app/response'

  FORMATS = {
    'html' => 'text/html',
    'rb'   => 'text/html'
  }

  def call(env)
    Request.new(env).response
  end

end