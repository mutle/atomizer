require 'test_helper'
require 'atomizer'

class AtomizerFeedTest < Test::Unit::TestCase
  # example from http://www.atomenabled.org/developers/syndication/atom-format-spec.php
  EXAMPLE_ATOM = <<-XML
<?xml version="1.0" encoding="utf-8"?>
<feed xmlns="http://www.w3.org/2005/Atom">
  <title type="text">dive into mark</title>
  <subtitle type="html">
    A &lt;em&gt;lot&lt;/em&gt; of effort
    went into making this effortless
  </subtitle>
  <updated>2005-07-31T12:29:29Z</updated>
  <id>tag:example.org,2003:3</id>
  <link rel="alternate" type="text/html"
    hreflang="en" href="http://example.org/"/>
  <link rel="self" type="application/atom+xml"
    href="http://example.org/feed.atom"/>
  <rights>Copyright (c) 2003, Mark Pilgrim</rights>
  <generator uri="http://www.example.com/" version="1.0">
    Example Toolkit
  </generator>
  <entry>
    <title>Atom draft-07 snapshot</title>
    <link rel="alternate" type="text/html"
      href="http://example.org/2005/04/02/atom"/>
    <link rel="enclosure" type="audio/mpeg" length="1337"
      href="http://example.org/audio/ph34r_my_podcast.mp3"/>
    <id>tag:example.org,2003:3.2397</id>
    <updated>2005-07-31T12:29:29Z</updated>
    <published>2003-12-13T08:29:29-04:00</published>
    <author>
      <name>Mark Pilgrim</name>
      <uri>http://example.org/</uri>
      <email>f8dy@example.com</email>
    </author>
    <contributor>
      <name>Sam Ruby</name>
    </contributor>
    <contributor>
      <name>Joe Gregorio</name>
    </contributor>
    <content type="xhtml" xml:lang="en"
      xml:base="http://diveintomark.org/">
      <div xmlns="http://www.w3.org/1999/xhtml">
        <p><i>[Update: The Atom draft is finished.]</i></p>
      </div>
    </content>
  </entry>
</feed>
    XML

  def setup
    super
    @feed = Atomizer::Feed.parse EXAMPLE_ATOM
    @entry = @feed.entries.first
  end

  def test_parse_feed_id
    assert_equal "tag:example.org,2003:3", @feed.id
  end

  def test_parse_feed_title
    assert_equal "dive into mark", @feed.title
  end
  
  def test_parse_feed_subtitle
    assert @feed.subtitle.include? "effort"
  end

  def test_parse_feed_updated
    assert_equal 2005, @feed.updated.year
  end

  def test_parse_feed_links
    assert_equal 2, @feed.links.size
    assert_equal "http://example.org/", @feed.links[0].href
    assert_equal "alternate", @feed.links[0].rel
    assert_equal "application/atom+xml", @feed.links[1].type
  end

  def test_parse_feed_rights
    assert @feed.rights.include? "Copyright"
  end

  def test_parse_feed_generator
    assert @feed.generator.name.include? "Example Toolkit"
    assert_equal "http://www.example.com/", @feed.generator.uri
    assert_equal "1.0", @feed.generator.version
  end

  def test_parse_feed_entries
    assert_equal 1, @feed.entries.size
  end

  def test_parse_feed_entry_id
    assert_equal "tag:example.org,2003:3.2397", @entry.id
  end

  def test_parse_feed_entry_title
    assert_equal "Atom draft-07 snapshot", @entry.title
  end

  def test_parse_feed_entry_links
    assert_equal 2, @entry.links.size
    assert_equal "http://example.org/2005/04/02/atom", @entry.links[0].href
    assert_equal "alternate", @entry.links[0].rel
    assert_equal "audio/mpeg", @entry.links[1].type
    assert_equal "1337", @entry.links[1].length
  end

  def test_parse_feed_entry_content
    assert @entry.content.body.include? "Update: The Atom draft is finished."
    assert_equal "xhtml", @entry.content.type
  end

  def test_parse_feed_dates
    assert_equal 2005, @entry.updated.year
    assert_equal 2003, @entry.published.year
  end

  def test_parse_feed_author
    assert_equal "Mark Pilgrim", @entry.authors.first.name
    assert_equal "http://example.org/", @entry.authors.first.uri
    assert_equal "f8dy@example.com", @entry.authors.first.email
  end

  def test_parse_feed_contributor
    assert_equal 2, @entry.contributors.size
    assert_equal "Sam Ruby", @entry.contributors[0].name
    assert_nil @entry.contributors[0].uri
    assert_nil @entry.contributors[0].email
    assert_equal "Joe Gregorio", @entry.contributors[1].name
  end

  def test_generate_feed
    assert @feed.to_atom.include?("<entry")
  end
end
