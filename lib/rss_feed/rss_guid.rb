module RSSFeed
  class RSSGuid
    # Initializes the link.
    def initialize(node)
      @node = node
    end
  
    # Content
    def content
      @node.content
    end

    # Is permalink?
    def is_permalink?
      @node["isPermaLink"]
    end
  end
end
