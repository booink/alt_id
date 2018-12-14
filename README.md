# AltId

alt_id provide obfuscated and url safe id of ActiveRecord with reference transparency.
alt_id は難読かつURLセーフなActiveRecordのIDを参照透過的に使えるようにするgemです

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'alt_id'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install alt_id

## Usage

```ruby
# app/models/some.rb
class Some < ActiveRecord
  alternate_id
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/booink/alt_id. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the AltId project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/alt_id/blob/master/CODE_OF_CONDUCT.md).
