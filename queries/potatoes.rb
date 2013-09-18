# -------------------------------------------------------------------
# Inner Circle Query
# -------------------------------------------------------------------
#
#
#   Author : PLIQUE Guillaume
#   Organization : Medialab - Sciences Po
#   Version : 1.0

require_relative "subqueries.rb"
require_relative "../tools/mixins.rb"

class Query
    include Helpers::Export

    # Base properties definition
    def initialize

        # Headers
        @base_header = ["population"] + (1..5).map {|x| "#{x}ARS"}
        @potatoes_header = ["combination", "count"]

        # Populations
        @total = CrossARAuthors.get
        @wg1 = CrossARAuthors.getWG1
        @restricted_wg1 = CrossARAuthors.getRestrictedWG1

        @crossWG = CrossWGAuthors.get
    end

    # Query Execution
    def exec

        # Subparts
        target_numbers
        potatoes

        return @export
    end

    # Target Viz
    def target_numbers
        csv = [@base_header]

        populations = {
            'total' => @total,
            'wg1' => @wg1,
            'restricted_wg1' => @restricted_wg1
        }

        count = 0
        populations.each do |name, pop|
            count += 1
            csv.push([name] + (1..5).map {|x| 0})

            for author in pop
                csv[count][author._data[:ars].length] += 1
            end
        end

        addToExport({:name => "target_numbers", :data => csv})
    end

    # Potato Viz
    def potatoes
        csv = [@potatoes_header]
        combinations = {}

        for author in @crossWG
            combinations[author._data[:wgs]] ||= 0
            combinations[author._data[:wgs]] += 1

            if author._data[:wgs].length > 1
                for wg in author._data[:wgs]
                    combinations[[wg]] += 1
                end
            end
        end

        combinations.each {|combination, count| csv.push([combination.inspect, count])}

        addToExport({:name => "potatoes", :data => csv})
    end
end