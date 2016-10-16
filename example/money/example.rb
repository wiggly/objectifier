#!/usr/bin/env ruby
$LOAD_PATH.unshift('../../lib')
require 'objectifier'
require 'pp'
require 'money'

#
# To run this example you will have to install the 'money' gem
#

#
# Money objectifier example to show how custom transformers can be created
# to deserialize types that Objectifier does not know about
#
# We have a structure representing a bank account. It contains;
#
# id - integer, required
#
# balance - money
#
# overdraft_limit - money
#

Objectifier.factories.add_type(
  Money,
  ->(name, value) {
    return Objectifier::ErrorResult.err(name, "'value' not present") unless value.key?("amount")
    return Objectifier::ErrorResult.err(name, "'code' not present") unless value.key?("code")

    Objectifier::ValueResult.new(name, Money.new(value["amount"], value["code"]))
  })

obj = Objectifier.define do
  item :id, type: Integer
  item :balance, type: Money
  item :credit_limit, type: Money, required: false
end

puts "Objectifier"
pp obj

# example 1 - complete data
parameters = {
  "id" => 42,
  "balance" => { "amount" => 100_00, "code" => "CAD" },
  "credit_limit" => { "amount" => (-300_00), "code" => "CAD" },
}

puts "\nComplete Data Result"
result = obj.call(parameters)

if result.success?
  pp result.value
else
  pp result
end


# example 2 - required data
parameters = {
  "id" => 42,
  "balance" => { "amount" => 100_00, "code" => "CAD" },
}

puts "\nRequired Data Result"
result = obj.call(parameters)

if result.success?
  pp result.value
else
  pp result
end


# example 3 - missing a required field
parameters = {
  "id" => 42,
  "credit_limit" => { "amount" => (-300_00), "code" => "CAD" },
}

puts "\nIncomplete Data Result"
result = obj.call(parameters)

if result.success?
  pp result.value
else
  pp result
end


# example 4 - malformed data
parameters = {
  "id" => 42,
  "balance" => { "amount" => 100_00, "code" => "CAD" },
  "credit_limit" => { "code" => "CAD" },
}

puts "\nMalformed Data Result"
result = obj.call(parameters)

if result.success?
  pp result.value
else
  pp result
end
