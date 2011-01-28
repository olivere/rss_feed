# encoding: utf-8

require 'rss_feed'
require 'test/unit'
require 'open-uri'
require 'fakeweb'
require 'shoulda'

class TestChannelItem < Test::Unit::TestCase
  include RSSFeed 

  context "required elements" do
    setup do
      @channel = RSSChannel.open(VALID_XML)
      @item = @channel.items.first
    end
    should "have one item" do
      assert_equal 1, @channel.items.size
    end
    should "have title element" do
      assert_equal "Star City", @item.title
    end
    should "have link element" do
      assert_equal "http://liftoff.msfc.nasa.gov/news/2003/news-starcity.asp", @item.link
    end
    should "have description element with proper escaping" do
      assert_equal %Q(How do Americans get ready to work with Russians aboard the International Space Station? They take a crash course in culture, language and protocol at Russia's <a href="http://howe.iki.rssi.ru/GCTC/gctc_e.htm">Star City</a>.), @item.description
    end
  end

  context "optional elements" do
    setup do
      @channel = RSSChannel.open(VALID_XML)
      @item = @channel.items.first
    end
    should "have publication date" do
      assert_equal Time.utc(2003,6,3,9,39,21), @item.pub_date
    end
    should "have guid" do
      assert_not_nil guid = @item.guid
      assert_equal "http://liftoff.msfc.nasa.gov/2003/06/03.html#item573", guid.content
      assert !guid.is_permalink?
    end
  end

  VALID_XML = <<EOF
<?xml version="1.0"?> 
<rss version="2.0"> 
  <channel> 
    <title>Liftoff News</title> 
    <link>http://liftoff.msfc.nasa.gov/</link> 
    <description>Liftoff to Space Exploration.</description> 
    <language>en-us</language> 
    <pubDate>Tue, 10 Jun 2003 04:00:00 GMT</pubDate> 
    <lastBuildDate>Tue, 10 Jun 2003 09:41:01 GMT</lastBuildDate> 
    <docs>http://blogs.law.harvard.edu/tech/rss</docs> 
    <generator>Weblog Editor 2.0</generator> 
    <managingEditor>editor@example.com</managingEditor> 
    <webMaster>webmaster@example.com</webMaster> 
    <item> 
      <title>Star City</title> 
      <link>http://liftoff.msfc.nasa.gov/news/2003/news-starcity.asp</link> 
      <description>How do Americans get ready to work with Russians aboard the International Space Station? They take a crash course in culture, language and protocol at Russia's &lt;a href="http://howe.iki.rssi.ru/GCTC/gctc_e.htm"&gt;Star City&lt;/a&gt;.</description> 
      <pubDate>Tue, 03 Jun 2003 09:39:21 GMT</pubDate> 
      <guid>http://liftoff.msfc.nasa.gov/2003/06/03.html#item573</guid> 
    </item>
  </channel>
</rss>
EOF

end

