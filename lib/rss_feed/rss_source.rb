module RSSFeed
  class RSSSource
    # Initializes the source element.
    def initialize(node)
      @node = node
    end

    # URL (required)
    def url
      @node["url"]
    end

    # Content 
    def content
      @node.content
    end
  end
end
