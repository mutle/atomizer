module Atomizer
  class Workspace < FeedItem
    feed_tag_name "workspace"
    feed_attributes :collections, :title

    def initialize(*attrs)
      super(*attrs)
      @collections ||= []
    end

    def to_xml(xml)
      xml.workspace do
        xml['atom'].title title if title
        collections.each do |collection|
          collection.to_xml xml
        end
      end
    end
  end
end
