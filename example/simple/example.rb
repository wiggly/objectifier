#!/usr/bin/env ruby
$LOAD_PATH.unshift('../../lib')
require 'objectifier'
require 'pp'

#
# Simple objectifier example
#
# We have a structure representing a person. It contains;
#
# name - string, required
#
# email - string required
#
# dob - string, optional
# If not present in the data provided it will not be present in the structure returned.
#
# location - map, required
# This map contains lattidue and longitude.
#
# It is required since at least one of its children is required.
#
#

obj = Objectifier.define do
  item :name, type: String
  item :email, type: String
  item :dob, type: String, required: false # TODO: add date/time to the set of builtin transformers
  map :location do
    item :lat, type: Float
    item :lng, type: Float
  end
end

puts "Objectifier"
pp obj

# example 1 - complete data
parameters = {
  "name" => "John Doe",
  "email" => "john.doe@example.com",
  "dob" => "1964-03-21",
  "location" => {
    "lat" => 51.5077,
    "lng" => -0.1279,
  },
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
  "name" => "John Doe",
  "email" => "john.doe@example.com",
  "location" => {
    "lat" => 51.5077,
    "lng" => -0.1279,
  },
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
  "name" => "John Doe",
  "dob" => "1964-03-21",
  "location" => {
    "lat" => 51.5077,
    "lng" => -0.1279,
  },
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
  "name" => "John Doe",
  "email" => "john.doe@example.com",
  "dob" => "1964-03-21",
  "location" => {
    "lat" => "fred",
    "lng" => -0.1279,
  },
}

puts "\nMalformed Data Result"
result = obj.call(parameters)

if result.success?
  pp result.value
else
  pp result
end
