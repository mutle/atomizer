module Atomizer
  class Content < FeedItem
    feed_tag_name "content"
    feed_attributes :body, :type, :xml_lang, :xml_base

    def to_xml(xml)
      xml.content(@body, :type => type, "xml:lang" => @xml_lang, "xml:base" => @xml_base)
    end
  end
end
