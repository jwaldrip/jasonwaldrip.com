# A rack server for serving and rendering flat files.

require 'bundler/setup'
Bundler.require(:default)

module RackSite
  extend self

  FORMATS = {
    'html' => 'text/html',
    'rb'   => 'text/html'
  }

  def call(env)
    response, format = file_from_path(env['REQUEST_PATH'])
    render(response, format)
  rescue Errno::ENOENT
    response, format = file_from_path('/404')
    render(response, format, 404)
  end

  def file_from_path(path)
    # Determine basename and format
    name_matches     = path.match(/^(?<base_path>.*)\/(?<base_name>.[^\/\.]*)?(\.(?<format>[a-z]+))?$/) || {}
    base_path        = name_matches[:base_path] || '/'
    base_name        = name_matches[:base_name] || 'index'
    format           = name_matches[:format] || 'html'
    absolute_base    = File.join(base_path, base_name)

    # Fetch the Renderer
    file             = Dir[File.join "files", "#{absolute_base}.#{format}*"].first
    renderer_matches = file.to_s.match(/#{absolute_base}\.#{format}(\.(?<renderer>[a-z]+))?$/) || {}
    renderer         = renderer_matches[:renderer] || format
    render_method    = "render_using_#{renderer}"

    # Render the file
    contents         = File.read file.to_s
    rendered         = if respond_to?(render_method)
                         send(render_method, contents)
                       else
                         renderer_missing(renderer)
                       end

    [rendered, format]
  end

  # Renderers
  def render_using_html(contents)
    contents
  end

  def render_using_haml(contents, context = nil)
    context ||= binding
    Haml::Engine.new(contents).render(context)
  end

  def render_using_rb(contents)
    html     = Pygments.highlight(contents, lexer: 'ruby')
    css      = Pygments.css(:style => "monokai")
    template = File.read 'pygments.haml'
    render_using_haml(template, binding)
  end

  def renderer_missing(name)
    raise LoadError, "Unable to find a renderer for #{name}"
  end

  # Main Render
  def render(response, format, status = 200)
    headers                 = {}
    headers['Content-Type'] = FORMATS[format] if FORMATS[format]
    [status, headers, [response]]
  end

end

run RackSite