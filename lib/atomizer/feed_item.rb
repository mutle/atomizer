module Atomizer
  class FeedItem
    include Buildable

    class << self

      def feed_tag_name(tag_name=nil)
        @feed_tag_name = tag_name.to_s if tag_name
        @feed_tag_name
      end

      def feed_attributes(*attrs)
        @attributes ||= []
        if attrs && attrs.size > 0
          @attributes.push(*attrs)
          attrs.each do |a|
            attr_accessor a
          end
        end
        @attributes
      end

      def feed_no_collection_group_tag!
        @feed_no_collection_group_tag = true
      end

      def feed_no_collection_group_tag
        @feed_no_collection_group_tag || false
      end
    end

    def initialize(options={})
      self.class.feed_attributes.each do |a|
        if v = (options[a.to_sym] || options[a.to_s])
          meth = "#{a}="
          send(meth, v) if respond_to?(meth) && v && v != ""
        end
      end
    end

    def to_xml(xml, root_element=true)
      if root_element
        xml.send(self.class.feed_tag_name) do |child_xml|
          feed_attributes_to_xml(child_xml)
        end
      else
        feed_attributes_to_xml(xml)
      end
    end
    
    private

    def feed_attributes_to_xml(xml)
      self.class.feed_attributes.each do |a|
        v = send(a) if respond_to?(a)
        next if !v || v == ""
        a = "#{a}_" if a.to_s == "id"
        if v.is_a?(Array)
          next if v.size == 0
          if v.first.class.feed_no_collection_group_tag
            v.each do |obj|
              obj.to_xml xml
            end
          else
            xml.send(a.to_s) do |child_xml|
              v.each do |obj|
                obj.to_xml child_xml
              end
            end
          end
        elsif v.respond_to?(:to_xml)
          v.to_xml(xml)
        elsif v.respond_to?(:attributes)
          xml.send(a.to_s, v.attributes) do
            xml.text v
          end
        else
          xml.send(a.to_s, v.to_s)
        end
      end
    end

  end
end
