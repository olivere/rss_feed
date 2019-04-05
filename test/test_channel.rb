# encoding: utf-8

require 'rss_feed'
require 'test/unit'
require 'open-uri'
require 'shoulda'
require 'webmock/test_unit'

class TestFeed < Test::Unit::TestCase
  include RSSFeed

  def setup
    @channel = RSSChannel.open(VALID_XML)
  end

  context "on required elements" do
    should "have title element" do
      assert_equal "Liftoff News", @channel.title
    end
    should "have link element" do
      assert_equal "http://liftoff.msfc.nasa.gov/", @channel.link
    end
    should "have description element" do
      assert_equal "Liftoff to Space Exploration.", @channel.description
    end
  end

  context "on optional elements" do
    should "return language" do
      assert_equal "en-us", @channel.language
    end
    should "return publication date" do
      assert_equal Time.utc(2003,6,10,4,0,0), @channel.pub_date
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
