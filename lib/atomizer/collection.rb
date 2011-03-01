module Atomizer
  class Collection < FeedItem
    feed_attributes :href, :title, :accepts, :categories

    def initialize
      @accepts = []
      @categories = []
    end

    def to_xml(xml)
      xml.collection :href => href do
        xml['atom'].title title if title
        accepts.each do |accept|
          xml.accept accept
        end
      end
    end
  end
end
