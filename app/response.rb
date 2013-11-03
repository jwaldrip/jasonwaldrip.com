module FlatSite
  class Response

    autoload :ViewContext, 'app/view_context'

    DEFAULT_FILE   = 'index'
    CONTENT_TYPES = {
      html: 'text/html',
      rb:   'text/html'
    }

    attr_reader :request

    def initialize(request)
      @request = request
    end

    def render(file: file_for(request.path), status: 200, layout: :layout)
      contents = renderer_for(file).render(view_context)
      contents = layout_for(layout).render(view_context){ contents } if layout
      self.body << contents
      set_content_type
      [status, headers, body]
    end

    def headers
      @headers ||= {}
    end

    def body
      @body ||= []
    end

    def set_content_type
      headers['Content-Type'] = CONTENT_TYPES[request.format.to_sym]
    end

    private

    def file_for(path)
      File.directory?(File.join 'interface', 'views', path) ? File.join(path, DEFAULT_FILE) : path
    end

    def renderer_for(file)
      Renderers.find File.join('views', file)
    end

    def layout_for(file)
      Renderers.find File.join('layouts', "#{file}.#{request.format}")
    end

    def view_context
      @view_context ||= ViewContext.new(self)
    end

  end
end