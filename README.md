# VimeoMe2

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/vimeo_me2`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'vimeo_me2'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install vimeo_me2

## Usage

This gem consists of two classes that can access respectively a user or a video object from Vimeo. Using the gem starts with obtaining an access token from [vimeo.com](https://developer.vimeo.com). When calling the classes, put in the access token and access the various methods. For instance:

```ruby
# Access your own user object
vimeo_user = VimeoMe2::User.new('12345hjhsjdshasd')

# Access someones user object
vimeo_user = VimeoMe2::User.new('12345hjhsjdshasd','username')

# Get access to a video
vimeo_video = VimeoMe2::User.new('12345hjhsjdshasd','196277011')

# Get comments on the video
vimeo_video.comments

# Delete the video (if you have access to do that)
vimeo_video.delete
```

At this moment the gem only returns the raw JSON response received from Vimeo. I do plan on extending this to also include a player embed method. But this is still work in progress.

## TODO

* Write tests
* Include all parameters in the various API calls
* Write methods for every Vimeo API endpoint

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/bo-oz/vimeo_me2. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
