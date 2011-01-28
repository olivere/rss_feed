module RSSFeed
  class RSSEnclosure
    # Initializes the enclosure element.
    def initialize(node)
      @node = node
    end

    # URL (required)
    def url
      @node["url"]
    end

    # Length (required)
    def length
      @node["length"]
    end

    # Media type (required)
    def type
      @node["type"]
    end
  end
end
