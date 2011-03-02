module Atomizer
  class Feed < FeedItem

    feed_attributes :id, :title, :subtitle, :updated, :published, :links, :rights, :generator, :generator_uri, :generator_version, :entries, :authors, :contributors

    class << self
      def parse(xml)
        doc = Nokogiri::XML(xml)
        feed = new
        feed.id = text(doc, "feed>id")
        feed.title = text(doc, "feed>title")
        feed.subtitle = text(doc, "feed>subtitle")
        feed.updated = parse_time text(doc, "feed>updated")
        feed.rights = text(doc, "feed>rights")
        generator = text(doc, "feed>generator")
        if generator
          feed.generator = Generator.new(:name => text(doc, "feed>generator"), :uri => attribute_text(doc, "feed>generator", "uri"), :version => attribute_text(doc, "feed>generator", "version"))
        end
        feed.links = parse_links(doc.css("feed>link"))

        doc.css("entry").each do |e|
          entry = Entry.new
          entry.id = text(e, "id")
          entry.title = text(e, "title")
          entry.content = parse_content e.css("content")
          entry.updated = parse_time(text(e, "updated"))
          entry.published = parse_time(text(e, "published"))
          entry.authors = parse_authors e.css("author"), Author
          entry.contributors = parse_authors e.css("contributor"), Contributor
          entry.links = parse_links(e.css("link"))
          feed.entries << entry
        end

        feed
      end

      private

      def text(element, selector)
        e = element.css(selector)
        return Text.new(e.first.text, e.first.attributes) if e && e.size > 0
        nil
      end

      def attribute_text(element, selector, attribute)
        e = element.css(selector)
        return Text.new(e.first.attr(attribute).to_s) if e && e.size > 0
        nil
      end

      def parse_time(text)
        Atomizer::Time.parse(text) if text
      end

      def parse_content(content)
        Content.new(:body => content.inner_html, :type => content.attr("type").to_s, :xml_lang => content.attr("lang").to_s, :xml_base => content.attr("base").to_s) 
      end

      def parse_links(link)
        links = []
        if link
          link.each do |l|
            rel = l.attr("rel").to_s
            type = l.attr("type").to_s
            hreflang = l.attr("hreflang").to_s
            href = l.attr("href").to_s
            length = l.attr("length").to_s
            links << Atomizer::Link.new(:rel => rel, :type => type, :hreflang => hreflang, :href => href, :length => length)
          end
        end
        links
      end

      def parse_authors(author, author_class)
        authors = []
        if author
          author.each do |a|
            name = a.css("name").text
            uri = a.css("uri").text
            email = a.css("email").text
            authors << author_class.new(:name => name, :uri => uri, :email => email)
          end
        end
        authors
      end
    end

    def initialize
      @authors = []
      @contributors = []
      @entries = []
      @links = []
    end

    def to_xml(xml, root_element=true)
      xml.feed :xmlns => "http://www.w3.org/2005/Atom" do
        super(xml, false)
      end
    end
  end
end
