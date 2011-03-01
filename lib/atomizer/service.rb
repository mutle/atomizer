module Atomizer
  class Service < FeedItem
    feed_tag_name "service"
    feed_attributes :workspaces

    def initialize(*attrs)
      super(*attrs)
      @workspaces ||= []
    end

    def to_xml(xml)
      xml.service :xmlns => "http://www.w3.org/2007/app", :"xmlns:atom" => "http://www.w3.org/2005/Atom" do
        workspaces.each do |workspace|
          workspace.to_xml xml
        end
      end
    end

    def setup_workspace(collection=nil)
      workspace = Workspace.new
      workspace.collections << collection if collection
      self.workspaces << workspace
    end
  end
end
