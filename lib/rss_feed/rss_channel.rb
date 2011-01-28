# encoding: utf-8

require 'nokogiri'
require 'rss_feed/core_ext'
require 'rss_feed/rss_category'
require 'rss_feed/rss_channel_item'
require 'rss_feed/rss_cloud'
require 'rss_feed/rss_guid'
require 'rss_feed/rss_image'
require 'rss_feed/rss_text_input'
require 'rss_feed/open_search'

module RSSFeed
  # RSSFeed::RSSChannel is the central place for
  # working with feeds in the RSS format.
  #
  # Opening an RSS feed from the network or a file system
  # is done like this:
  #
  #   feed = RSSFeed::RSSChannel.open(open("http://example.com/rss.xml"))
  #
  # If you have a file you should do:
  #
  #   f = File.open("rss.xml")
  #   feed = RSSFeed::RSSChannel.open(f)
  #   f.close
  #
  # If you have an XML string you can do:
  #
  #   feed = RSSFeed::RSSChannel.open("<rss version='1.0'> ...")
  #
  # One can open and parse the feed like so:
  #
  #   RSSFeed::RSSChannel.open(...) do |feed|
  #     puts feed.title
  #     feed.items do |item|
  #       puts item.title
  #     end
  #   end
  #
  # You can access OpenSearch extensions by using +RSSChannel.open_search+.
  # Access to other embedded XML types are available by using RSSChannel.doc+
  # directly. It's a +Nokogiri::XML+ instance.
  #
  # RSSFeed uses Nokogiri for parsing.
  #
  class RSSChannel

    attr_reader :doc

    def initialize(doc)
      @doc = doc
    end

    def self.open(string_or_io, url = nil, encoding = nil)
      doc = Nokogiri::XML(string_or_io, url, encoding)
      channel = RSSChannel.new(doc)
      yield channel if block_given?
      channel
    end

    # Title (required).
    def title
      @doc.at_xpath("rss/channel/title").content
    end

    # Link (required).
    def link 
      @doc.at_xpath("rss/channel/link").content
    end
    
    # Description (required).
    def description
      @doc.at_xpath("rss/channel/description").content
    end
    
    # Language (optional).
    def language
      @doc.at_xpath("rss/channel/language").try(:content)
    end
    
    # Copyright (optional).
    def copyright
      @doc.at_xpath("rss/channel/copyright").try(:content)
    end
    
    # Managing editor (optional).
    def managing_editor
      @doc.at_xpath("rss/channel/managingEditor").try(:content)
    end
    
    # Publication date (optional).
    def pub_date
      if date = @doc.at_xpath("rss/channel/pubDate").try(:content)
        Time.rfc822(date)
      end
    end
    
    # Last build date (optional).
    def last_build_date
      if date = @doc.at_xpath("rss/channel/lastBuildDate").try(:content)
        Time.rfc822(date)
      end
    end
    
    # Category (optional).
    def category
      if node = @doc.at_xpath("rss/channel/category")
        RSSCategory.new(node)
      end
    end
    
    # Generator (optional).
    def generator
      @doc.at_xpath("rss/channel/generator").try(:content)
    end
    
    # Documentation link (optional).
    def docs
      @doc.at_xpath("rss/channel/docs").try(:content)
    end

    # Cloud (optional)
    def cloud
      if node = @doc.at_xpath("rss/channel/cloud")
        RSSCloud.new(node)
      end
    end
    
    # Time to live in minutes (optional).
    def ttl
      @doc.at_xpath("rss/channel/ttl").try(:content).nonzero?
    end
    
    # Image (optional).
    def image
      if node = @doc.at_xpath("rss/channel/image")
        RSSImage.new(node)
      end
    end
    
    # PICS rating (optional).
    def rating
      @doc.at_xpath("rss/channel/rating").try(:content)
    end
    
    # Text input box (optional).
    def text_input
      if node = @doc.at_xpath("rss/channel/textInput")
        RSSTextInput.new(node)
      end
    end
    
    # Hint for aggregators telling them which hours they can skip (optional).
    def skip_hours
      @doc.at_xpath("rss/channel/skipHours").try(:content).nonzero?
    end
    
    # Hint for aggregators telling them which days they can skip (optional).
    def skip_days
      @doc.at_xpath("rss/channel/skipDays").try(:content).nonzero?
    end
    
    # Array of channel items (optional).
    def items
      nodes = @doc.xpath("rss/channel/item") || []
      nodes.map { |node| RSSChannelItem.new(node) }
    end

    # Open Search extensions (optional)
    def open_search
      @open_search ||= OpenSearch.new(@doc)
    end

  end
end

