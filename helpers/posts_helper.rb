module PostsHelper

  Post = Class.new Struct.new(:name, :link)

  def posts
    Dir.glob(File.join 'pages', 'posts', '*').map do |file|
      Post.new.tap do |post|
        post.link = File.join path, File.basename(file, '.*')
        post.name = File.basename(post.link, '.*').titleize
      end
    end.delete_if { |post| post.name.downcase == 'index' }
  end

end
