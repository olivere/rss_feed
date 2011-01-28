module RSSFeed
  class RSSCategory
    # Initializes the link.
    def initialize(node)
      @node = node
    end

    # Identifies the domain (optional).
    def domain 
      @node["domain"]
    end

    # Content of the RSS category.
    def content
      @node.content
    end
  end
end
