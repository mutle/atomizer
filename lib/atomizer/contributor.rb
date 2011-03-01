module Atomizer
  class Contributor < Author
    feed_tag_name "contributor"
    feed_attributes :name, :uri, :email
    feed_no_collection_group_tag!
  end
end

