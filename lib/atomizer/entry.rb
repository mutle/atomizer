module Atomizer
  class Entry < FeedItem
    feed_tag_name "entry"
    feed_attributes :id, :title, :links, :updated, :published, :authors, :contributors, :content
    feed_no_collection_group_tag!

    def initialize(*attrs)
      super(*attrs)
      @content_type ||= "html"
      @links ||= []
    end
  end
end
