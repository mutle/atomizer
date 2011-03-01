require 'test_helper'
require 'atomizer'

class AtomizerBuilderTest < Test::Unit::TestCase

  def setup
    super
    @feed = Atomizer::Feed.new
    @builder = Atomizer::Builder.new
  end

  def test_create_empty_feed
    assert @builder.to_atom(@feed).include?("<feed")
    assert @feed.to_atom.include?("<feed")
    assert !@feed.to_atom.include?("<entry")
  end

  def test_create_feed_entry
    @feed.entries << Atomizer::Entry.new(:title => "Foo")
    assert @builder.to_atom(@feed).include?("<title>Foo</title>")
  end

end

