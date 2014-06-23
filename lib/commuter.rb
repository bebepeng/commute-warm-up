require 'date'

class Commuter
  attr_reader :commutes

  def initialize(input)
    @commutes = input.each_with_object({}) do |entry, commutes|
      if commutes.has_key?(entry['Person'])
        commutes[entry['Person']] << {week: entry['Week'].to_i,
                                       day: entry['Day'],
                                       mode: entry['Mode'],
                                       inbound: entry['Inbound'].to_i,
                                       outbound: entry['Outbound'].to_i,
                                       distance: entry['Distance'].to_i,}
        commutes[entry['Person']].sort_by! { |commute| DateTime.parse(commute[:day]).wday}
        commutes[entry['Person']].sort_by! { |commute| commute[:week]}
      else
        commutes[entry['Person']] = [{week: entry['Week'].to_i,
                                      day: entry['Day'],
                                      mode: entry['Mode'],
                                      inbound: entry['Inbound'].to_i,
                                      outbound: entry['Outbound'].to_i,
                                      distance: entry['Distance'].to_i,}]
      end

    end
  end

  def all
    commutes
  end
end