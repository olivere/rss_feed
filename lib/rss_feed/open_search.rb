require 'rss_feed/open_search_query'

module RSSFeed
  class OpenSearch
    # Initializes the Open Search extensions.
    def initialize(node)
      @node = node
    end

    def present?
      !self.total_results.nil?
    end

    def total_results
      @node.at_xpath("rss:rss/rss:channel/opensearch:totalResults", ::RSSFeed::NS).content.to_i rescue nil
    end

    def start_index
      @node.at_xpath("rss:rss/rss:channel/opensearch:startIndex", ::RSSFeed::NS).content.to_i rescue nil
    end

    def items_per_page
      @node.at_xpath("rss:rss/rss:channel/opensearch:itemsPerPage", ::RSSFeed::NS).content.to_i rescue nil
    end

    # queries
    def queries
      nodes = @node.xpath("rss:rss/rss:channel/opensearch:Query", ::RSSFeed::NS) rescue nil
      nodes.map { |node| OpenSearchQuery.new(node) } if nodes
    end

    # first
    # previous
    # next
    # last
    # search
  end
end
