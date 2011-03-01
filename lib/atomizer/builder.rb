module Atomizer
  class Builder
    def to_atom(object)
      builder = Nokogiri::XML::Builder.new do |xml|
        object.to_xml(xml)
      end
      builder.to_xml
    end
  end
end
