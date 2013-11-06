# -------------------------------------------------------------------
# Potato Query
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
        @crossWG = CrossWGAuthors.get
    end

    # Query Execution
    def exec

        # Subparts
        target_numbers
        potatoes
        ar_potatoes

        return @export
    end

    # Target Viz
    def target_numbers
        csv = [@base_header]

        populations = {
            'total' => CrossARAuthors.get,
            'roled_total : LA + RE + LCA' => CrossARAuthors.getByRoles,
            'wg1' => CrossARAuthors.get(1),
            'roled_wg1: LA + LCA' => CrossARAuthors.getByRoles(1, ['LA', 'LCA']),
            'roled_wg1 2: LA + LCA + RE' => CrossARAuthors.getByRoles(1)
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

            # if author._data[:wgs].length > 1
            #     for wg in author._data[:wgs]
            #         combinations[[wg]] += 1
            #     end
            # end

            # if author._data[:wgs].length > 2
            #     combinations[[1, 2]] ||= 0
            #     combinations[[1, 3]] ||= 0
            #     combinations[[2, 3]] ||= 0
            #     combinations[[1, 2]] += 1
            #     combinations[[1, 3]] += 1
            #     combinations[[2, 3]] += 1
            # end
        end

        combinations.each {|combination, count| csv.push([combination.inspect, count])}

        addToExport({:name => "potatoes", :data => csv})
    end

    # AR Potatoes Viz
    def ar_potatoes
        csv = [@potatoes_header]
        combinations = {}

        for author in CrossARAuthors.get
            combinations[author._data[:ars]] ||= 0
            combinations[author._data[:ars]] += 1
        end

        combinations.each {|combination, count| csv.push([combination.inspect, count])}

        addToExport({:name => "ar_potatoes", :data => csv})
    end
end