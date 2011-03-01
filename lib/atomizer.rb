require 'nokogiri'

module Atomizer
  autoload :Author, 'atomizer/author'
  autoload :Builder, 'atomizer/builder'
  autoload :Buildable,'atomizer/buildable'
  autoload :Collection,'atomizer/collection'
  autoload :Content,'atomizer/content'
  autoload :Contributor,'atomizer/contributor'
  autoload :Entry,'atomizer/entry'
  autoload :Feed,'atomizer/feed'
  autoload :Generator,'atomizer/generator'
  autoload :FeedItem, 'atomizer/feed_item'
  autoload :Link,'atomizer/link'
  autoload :Service,'atomizer/service'
  autoload :Text,'atomizer/text'
  autoload :Time,'atomizer/time'
  autoload :Workspace,'atomizer/workspace'
end
