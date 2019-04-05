# encoding: utf-8

require 'rss_feed'
require 'test/unit'
require 'open-uri'
require 'webmock/test_unit'

class TestOpen < Test::Unit::TestCase
  include RSSFeed

  def test_open_from_string
    assert_not_nil channel = RSSChannel.open(VALID_XML)
  end

  def test_open_from_file
    f = File.open(File.dirname(__FILE__) + "/rss.xml")
    assert_not_nil channel = RSSChannel.open(f)
    f.close
  end

  def test_open_from_the_internets
    stub_request(:get, "http://example.com/rss.xml").to_return(:status => 200, :body => VALID_XML)
    assert_not_nil channel = RSSChannel.open(open("http://example.com/rss.xml"))
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
