# OmniAuth Netflix

This gem is an OmniAuth 1.0 Strategy for the [Netflix API](http://developer.netflix.com/)

It supports the Netflix REST API which uses OAuth 1.0a.

## Usage

Add the strategy to your `Gemfile` alongside OmniAuth:

```ruby
gem 'omniauth'
gem 'omniauth-netflix'
```

Then integrate the strategy into your middleware:

```ruby
use OmniAuth::Builder do
  provider :netflix, ENV['NETFLIX_KEY'], ENV['NETFLIX_SECRET']
end
```

In Rails, you'll want to add to the middleware stack:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :netflix, ENV['NETFLIX_KEY'], ENV['NETFLIX_SECRET']
end
```

You will have to put in your consumer key and secret (Netflix refers to them as Key and Shared Secret).

For additional information, refer to the [OmniAuth wiki](https://github.com/intridea/omniauth/wiki).

## <a name="build"></a>Build Status
[![Build Status](https://secure.travis-ci.org/spagalloco/omniauth-netflix.png?branch=master)][travis]

[travis]: http://travis-ci.org/spagalloco/omniauth-netflix

## <a name="dependencies"></a>Dependency Status
[![Dependency Status](https://gemnasium.com/spagalloco/omniauth-netflix.png?travis)][gemnasium]

[gemnasium]: https://gemnasium.com/spagalloco/omniauth-netflix

## Contributing

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2011 Steve Agalloco. See [LICENSE](https://github.com/spagalloco/omniauth-netflix/blob/master/LICENSE.md) for details.