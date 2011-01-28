# encoding: utf-8

require 'rss_feed'
require 'test/unit'
require 'open-uri'
require 'fakeweb'
require 'shoulda'

class TestOpenSearchExtensions < Test::Unit::TestCase
  include RSSFeed

  context "when parsing feed with OpenSearch extensions" do
    setup do
      @channel = RSSChannel.open(VALID_XML_WITH_OPENSEARCH)
    end
    should "have opensearch extension" do
      assert_not_nil @channel.open_search
      assert @channel.open_search.present?
    end
    should "have total_results" do
      assert_equal 4230000, @channel.open_search.total_results
    end
    should "have start_index" do
      assert_equal 21, @channel.open_search.start_index
    end
    should "have items_per_page" do
      assert_equal 10, @channel.open_search.items_per_page
    end
    should "have open search queries" do
      assert_not_nil queries = @channel.open_search.queries
      assert_equal 1, queries.size
      assert_not_nil query = queries.first
      assert_equal "request", query.role
      assert_equal "New York History", query.search_terms
      assert_equal 1, query.start_page
    end
  end

  VALID_XML_WITH_OPENSEARCH = <<EOF
<?xml version="1.0"?> 
<rss version="2.0" 
     xmlns:opensearch="http://a9.com/-/spec/opensearch/1.1/">
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
    <opensearch:totalResults>4230000</opensearch:totalResults>
    <opensearch:startIndex>21</opensearch:startIndex>
    <opensearch:itemsPerPage>10</opensearch:itemsPerPage>
    <opensearch:Query role="request" searchTerms="New York History" startPage="1" />
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
