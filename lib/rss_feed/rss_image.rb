module RSSFeed
  class RSSImage
    # Initializes the image element.
    def initialize(node)
      @node = node
    end

    # URL (required)
    def url
      @node.at_xpath("url").content
    end

    # Title (required)
    def title
      @node.at_xpath("title").content
    end

    # Link (required)
    def link
      @node.at_xpath("link").content
    end

    # Width (optional)
    def width
      @node.at_xpath("width").try(:content).to_i
    end

    # Height (optional)
    def height
      @node.at_xpath("height").try(:content).to_i
    end

    # Description (optional)
    def description
      @node.at_xpath("description").try(:content)
    end
  end
end
