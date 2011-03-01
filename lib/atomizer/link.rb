module Atomizer
  class Link < FeedItem
    feed_tag_name "link"
    feed_attributes :rel, :type, :length, :href
    feed_no_collection_group_tag!

    def to_xml(xml)
      xml.link :rel => @rel, :type => @type, :length => @length, :href => @href
    end
  end
end
