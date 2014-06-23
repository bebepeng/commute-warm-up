require 'spec_helper'
require 'commuter'
require 'csv'

describe Commuter do
  it 'returns the commute data for a person' do
    input = CSV.parse("Person,Week,Day,Mode,Inbound,Outbound,Distance
Elsa,1,Monday,Drive,30,50,24
Elsa,1,Tuesday,Drive,35,52,24", :headers => true)

    output = {
      "Elsa" => [
        {
          week: 1,
          day: "Monday",
          mode: "Drive",
          inbound: 30,
          outbound: 50,
          distance: 24
        },
        {
          week: 1,
          day: "Tuesday",
          mode: "Drive",
          inbound: 35,
          outbound: 52,
          distance: 24
        },
      ]
    }

    commuter = Commuter.new(input)
    expect(commuter.all).to eq output
  end

  it 'returns the commute data for a person sorted by week' do
    input = CSV.parse("Person,Week,Day,Mode,Inbound,Outbound,Distance
Elsa,2,Monday,Drive,30,50,24
Elsa,1,Tuesday,Drive,35,52,24", :headers => true)

    output = {
      "Elsa" => [
        {
          week: 1,
          day: "Tuesday",
          mode: "Drive",
          inbound: 35,
          outbound: 52,
          distance: 24
        },
        {
          week: 2,
          day: "Monday",
          mode: "Drive",
          inbound: 30,
          outbound: 50,
          distance: 24
        },
      ]
    }

    commuter = Commuter.new(input)
    expect(commuter.all).to eq output
  end

  it 'returns the commute data for a person sorted by week and then day of the week' do
    input = CSV.parse("Person,Week,Day,Mode,Inbound,Outbound,Distance
Elsa,1,Tuesday,Drive,35,52,24
Elsa,2,Monday,Drive,30,50,24
Elsa,1,Monday,Drive,35,52,24", :headers => true)

    output = {
      "Elsa" => [
        {
          week: 1,
          day: "Monday",
          mode: "Drive",
          inbound: 35,
          outbound: 52,
          distance: 24
        },
        {
          week: 1,
          day: "Tuesday",
          mode: "Drive",
          inbound: 35,
          outbound: 52,
          distance: 24
        },
        {
          week: 2,
          day: "Monday",
          mode: "Drive",
          inbound: 30,
          outbound: 50,
          distance: 24
        },
      ]
    }

    commuter = Commuter.new(input)
    expect(commuter.all).to eq output
  end

  it 'returns the commute data for many people' do
    input = CSV.parse("Person,Week,Day,Mode,Inbound,Outbound,Distance
Elsa,2,Monday,Drive,30,50,24
Kevin,2,Monday,Drive,30,50,24
Elsa,1,Tuesday,Drive,35,52,24
Kevin,1,Monday,Drive,35,52,24", :headers => true)

    output = {
      "Elsa" => [
        {
          week: 1,
          day: "Tuesday",
          mode: "Drive",
          inbound: 35,
          outbound: 52,
          distance: 24
        },
        {week: 2,
         day: "Monday",
         mode: "Drive",
         inbound: 30,
         outbound: 50,
         distance: 24}],

      "Kevin" => [
        {
          week: 1,
          day: "Monday",
          mode: "Drive",
          inbound: 35,
          outbound: 52,
          distance: 24
        },
        {week: 2,
         day: "Monday",
         mode: "Drive",
         inbound: 30,
         outbound: 50,
         distance: 24},
      ]
    }

    commuter = Commuter.new(input)
    expect(commuter.all).to eq output
  end
end