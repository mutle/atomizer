Atomizer
--------

Atomizer is a Ruby library for parsing and generating Atom feeds.


Installation
============

        $ gem install atomizer


Usage
=====

Parsing an Atom feed:

       require 'open-uri'
       feed = Atomizer::Feed.parse(open('http://feeds.feedburner.com/gemcutter-latest').read) 


Generating an Atom feed:

      feed = Atomizer::Feed.new
      feed.title = "My Atom Feed"
      feed.to_atom # => "<?xml version=\"1.0\"?>\n<feed xmlns=\"http://www.w3.org/2005/Atom\">\n  <title>My Atom Feed</title>\n</feed>\n"

Copyright
=========

Copyright (c) 2011 Mutwin Kraus

Atomizer is licensed under the [MIT License](https://github.com/mutle/atomizer/blob/master/LICENSE).
