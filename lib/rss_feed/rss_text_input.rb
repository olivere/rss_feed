module RSSFeed
  class RSSTextInput
    # Initializes the text input element.
    def initialize(node)
      @node = node
    end

    # Title (required)
    def title
      @node.at_xpath("title").content
    end

    # Description (required)
    def description
      @node.at_xpath("description").content
    end

    # Name (required)
    def name 
      @node.at_xpath("name").content
    end

    # Link (required)
    def link
      @node.at_xpath("link").content
    end
  end
end
