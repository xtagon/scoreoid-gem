## NOTICE: Project is unmaintained because the Scoroid API no longer exists.

This repository is left for historical reasons.

Scoreoid Ruby
=============

Summary
-------

Scoreoid Ruby is a wrapper for the [Scoreoid](https://www.scoreoid.com/) API.

Installation
------------

Add this line to your application's Gemfile:

    gem 'scoreoid'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install scoreoid

Usage
-----

Full documentation is [available online](http://rubydoc.info/gems/scoreoid/frames).

To get started, configure Scoreoid Ruby with your API key and game ID:

    require 'scoreoid'
    
    Scoreoid.configure(api_key: 'YOUR_API_KEY', game_id: 'YOUR_GAME_ID')

Then you can start querying Scoreoid API methods:

    new_players_count = Scoreoid::API.query('countPlayers', start_date: '2009-08-04')

Any Scoreoid API method may be called in this mannor. See the [Scoreoid Wiki](http://wiki.scoreoid.net/category/api/) for information on available API methods.

Future versions of Scoreoid Ruby will provide a more object-oriented mannor of querying data. See the `Scoreoid::Player` class for a basic example of this.

Contributing
------------

Contributions are most welcome!

1. [Fork it on Bitbucket](https://bitbucket.org/xtagon/scoreoid-ruby-gem/fork)
2. Create your feature branch (`git checkout -b feature/my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

Please use the [issue tracker](https://bitbucket.org/xtagon/scoreoid-ruby-gem/issues?status=new&status=open) if you encounter a bug or have a feature request.

License
-------

Copyright © 2012 [Justin Workman](mailto:xtagon@gmail.com)

MIT License

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
