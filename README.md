# Objectifier

[![Gem Version](https://badge.fury.io/rb/objectifier.svg)](https://badge.fury.io/rb/objectifier)
[![Build Status](https://travis-ci.org/wiggly/objectifier.svg?branch=master)](https://travis-ci.org/wiggly/objectifier)

De-serialise plain hashes into objects.

The rationale behind this is to be able to take input from external sources such as REST calls or log files and turn them into graphs of objects or find out why they cannot be tranformed.

This is the first cut of the code and it currently only handles a small number of types but you can add your own already. Better default types will be coming soon.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'objectifier'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install objectifier

## Usage

Create custom transformers, create an objectifier and use it to de-serialise hashes.

```
  require 'objectifier'
  require 'money'

  # Add a custom tranformer for Money values
  Objectifier.factories.add_type(
    :money,
    ->(name, value) {
      Objectifier::ValueResult.new(name, Money.new(value["amount"], value["code"]))
    })

  # define an objectifier that can be used to de-serialise a given format
  obj = Objectifier.define do
    item :name, type: :string, required: false

    items :accounts, type: :integer

    item :budget, type: :money

    item :length, type: :integer, required: false

    map :activity do
      item :clicks, type: :integer
      item :ctr, type: :float
    end
  end

  # some test parameters
  parameters = {
    "name" => "Billy",

    "accounts" => [ "100", "300", "150", "23" ],

    "budget" => {
      "amount" => "10.00.0",
      "code" => "GBP",
    },

    "length" => "42",

    "activity" => {
      "clicks" => "83351",
      "ctr" => "3.1",
    },
  }

  # transform input into real objects or return detailed error messages
  result = obj.call(parameters)

  if result.success?
    puts result.value
  else
    puts result
  end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/wiggly/objectifier.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
