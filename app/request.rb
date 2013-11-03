module FlatSite
  class Request

    DEFAULT_FORMAT = 'html'

    attr_reader :env

    def initialize(env)
      @env = env
    end

    def path
      env['REQUEST_PATH']
    end

    def headers
      env.reduce({}) do |hash, (key, value)|
        next hash unless /^HTTP_(?<name>.+)/ =~ key
        hash.merge name.downcase.to_sym => value
      end
    end

    def format
      (ext = File.extname path).empty? ? DEFAULT_FORMAT : ext.sub(/\./, '')
    end

    def response
      Response.new(self).render
    rescue RendererNotFound
      Response.new(self).render(file: '500.html', status: 500)
    rescue FileNotFound
      Response.new(self).render(file: '404.html', status: 404)
    end

  end
end