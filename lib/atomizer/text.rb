module Atomizer
  class Text < String
    def attributes
      @attributes ||= {}
    end

    def initialize(str, attrs={})
      super(str.to_s)
      attrs.each do |k,v|
        attributes[k.to_s] = v.value
      end
    end
  end
end
