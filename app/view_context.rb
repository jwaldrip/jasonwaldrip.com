module FlatSite
  class Response
    class ViewContext

      def initialize(response)
        @response = response
      end

      def get_binding
        binding
      end

      def path
        @response.request.path
      end

      def files
        Dir.glob(File.join 'interface', 'views', path, '*').map do |file|
          File.basename File.basename(file, '.*'), '.*'
        end - [DEFAULT_FILE]
      end

      def stylesheet_tag(path)
        stylesheet_exists?(path) ? "<link rel='stylesheet' type='text/css' href='/#{File.join('stylesheets', path.to_s)}.css'>" : ''
      end

      def page_stylesheet_tag
        file = @response.send(:file_for, path.to_s)
        base_path = File.join File.dirname(file), File.basename(file,  '.*')
        stylesheet_tag base_path
      end

      def link_to(name, link)
        "<a href='#{link}'>#{name}</a>"
      end

      private

      def stylesheet_exists?(name)
        File.exists?(File.join('public', 'stylesheets', "#{name}.css")) ||
          File.exists?(File.join('public', 'stylesheets', 'sass', "#{name}.scss"))
      end

    end
  end
end
