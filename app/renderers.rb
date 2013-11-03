module FlatSite
  module Renderers
    extend self

    autoload :Rb, 'app/renderers/rb'
    autoload :Haml, 'app/renderers/haml'
    autoload :Html, 'app/renderers/html'

    def find(file)
      template = Dir[File.join 'interface', "#{file}*"].first
      name = File.extname(template).sub(/\./, '')
      klass = const_get(name.split('_').map(&:capitalize).join, false)
      klass.new template
    rescue NameError, TypeError
      raise RendererNotFound, "could not find a renderer for #{file}"
    end

    class Base

      attr_reader :contents

      def initialize(file)
        @contents = File.read file
      end

      private

    end

  end
end