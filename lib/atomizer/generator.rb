module Atomizer
  class Generator < FeedItem
    feed_tag_name "generator"
    feed_attributes :name, :uri, :version

    def to_xml(xml)
      xml.generator @name, :uri => @uri, :version => @version
    end
  end
end
