module FlatSite
  module Renderers
    class Haml < Base

      def render(context = binding, &block)
        ::Haml::Engine.new(contents).render(context, &block)
      end

    end
  end
end