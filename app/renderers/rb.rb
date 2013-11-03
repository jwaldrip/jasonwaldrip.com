module FlatSite
  module Renderers
    class Rb < Base

      def render(*args)
        Pygments.highlight(contents, lexer: 'ruby')
      end

    end
  end
end