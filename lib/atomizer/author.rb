module Atomizer
  class Author < FeedItem
    feed_tag_name "author"
    feed_attributes :name, :uri, :email
    feed_no_collection_group_tag!
  end
end
