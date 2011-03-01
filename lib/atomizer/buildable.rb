module Atomizer
  module Buildable
    def to_atom
      builder = Builder.new
      builder.to_atom(self)
    end
  end
end

