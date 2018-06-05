# Uniqable

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/uniqable`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'uniqable'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install uniqable

## Usage

First include Uniqable concern to your model and then describe columns which you want to propose with uniq token.
```ruby
  class User < ActiveRecord::Base
    include Uniqable
    
    uniqable :uid, :another_column, :or_another_uid_column
  end
```

It generates unique and random token before each Model instance is created.

You can also create your own token callback method and set the field:

```ruby
def uniqable_uid(field)
  self[field] = 100_000 + rand(999_999)
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mpakus/uniqable.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
