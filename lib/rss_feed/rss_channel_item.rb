module RSSFeed
  class RSSChannelItem

    attr_reader :node

    def initialize(node)
      @node = node
    end

    # Title (required).
    def title
      @node.at_xpath("title").content
    end

    # Link (required).
    def link
      @node.at_xpath("link").content
    end

    # Description (required).
    def description
      @node.at_xpath("description").content
    end

    # Email address of the author (optional).
    def author
      @node.at_xpath("author").try(:content)
    end

    # Array of categories (optional).
    def categories
      if nodes = @node.xpath("category")
        nodes.map { |node| RSSCategory.new(node) }
      end
    end

    # Array of URLs to comments (optional).
    def comments
      if nodes = @node.xpath("comments")
        nodes.map { |node| node.content }.compact
      end
    end

    # Enclosure (optional).
    def enclosure
      if node = @node.at_xpath("enclosure")
        RSSEnclosure.new(node)
      end
    end

    # GUID (optional).
    def guid
      if node = @node.at_xpath("guid")
        RSSGuid.new(node)
      end
    end
    
    # Publication date (optional).
    def pub_date
      if date = @node.at_xpath("pubDate").try(:content)
        Time.rfc822(date)
      end
    end

    # Source (optional).
    def source
      if node = @node.at_xpath("source")
        RSSSource.new(node)
      end
    end

  end
end
