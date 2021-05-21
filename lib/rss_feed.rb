# Copyright (C) 2011 Oliver Eilhard
#
# This library is freely distributable under
# the terms of an MIT-style license.
# See COPYING or http://www.opensource.org/licenses/mit-license.php.

# This library is for parsing RSS feeds.

module RSSFeed
  VERSION = "0.3.0"

  # OpenSearch 1.1 Draft 4 namespace
  NS_OPENSEARCH_11 = "http://a9.com/-/spec/opensearch/1.1/"

  # Well-known namespaces for use in Nokogiri
  NS = {"rss" => "", "opensearch" => NS_OPENSEARCH_11}

  autoload :CoreExt,         'rss_feed/core_ext.rb'
  autoload :OpenSearch,      'rss_feed/open_search.rb'
  autoload :OpenSearchQuery, 'rss_feed/open_search_query.rb'
  autoload :RSSChannel,      'rss_feed/rss_channel.rb'
  autoload :RSSChannelItem,  'rss_feed/rss_channel_item.rb'
  autoload :RSSCategory,     'rss_feed/rss_category.rb'
  autoload :RSSCloud,        'rss_feed/rss_cloud.rb'
  autoload :RSSEnclosure,    'rss_feed/rss_enclosure.rb'
  autoload :RSSGuid,         'rss_feed/rss_guid.rb'
  autoload :RSSImage,        'rss_feed/rss_image.rb'
  autoload :RSSSource,       'rss_feed/rss_source.rb'
  autoload :RSSTextInput,    'rss_feed/rss_text_input.rb'
end
