# -------------------------------------------------------------------
# Axis 0 Query
# -------------------------------------------------------------------
#
#
#   Author : PLIQUE Guillaume
#   Organization : Medialab - Sciences Po
#   Version : 1.0

require_relative "subqueries.rb"
require_relative "../model/taxonomies.rb"
require_relative "../tools/mixins.rb"

class Query
    include Helpers::Export

    # Base properties definition
    def initialize

        # Headers
        @header = ["combination"] + (1..5).map {|i| "AR#{i}"}
        @header_bis = ["combination", "count"]
        @header_china = ["population", "count"]

        # Population
        # @population = CrossARAuthors.get
        @population = []

    end

    # Query Execution
    def exec

        # Subparts
        # viz0
        # viz0bis
        vizChina

        return @export
    end

    def viz0
        csv = [@header]

        # Total population
        row1 = ["total number of authors"]
        for ar in 1..5
            row1.push SQLQuery.get("SELECT DISTINCT author_id from participations WHERE ar = #{ar}").length
        end

        csv.push row1

        # Tricky Authors
        row2 = ["new authors"]
        row3 = ["consolidated authors"]
        row4 = ["jumping authors"]

        for ar in 1..5
            row2.push @population.select {|a| a._data[:ars][0] == ar}.length
            row3.push @population.select {|a| a._data[:ars].include?(ar) && a._data[:ars].include?(ar - 1)}.length
            row4.push @population.select {|a| a._data[:ars].include?(ar) && (a._data[:ars] - [ar, ar-1] - (1..5).select {|x| x > ar}).length > 0}.length
        end

        csv.push row2
        csv.push row3
        csv.push row4

        addToExport({:name => "viz0", :data => csv})
    end

    def viz0bis
        csv = [@header_bis]
        patterns = [
            [1, 2],
            [1, 2, 3],
            [2, 3],
            [1, 2, 3, 4],
            [1, 3, 4],
            [2, 3, 4],
            [3, 4],
            [1, 2, 4],
            [2, 4],
            [1, 4],
            [1, 2 ,3, 4, 5],
            [2, 3, 4, 5],
            [1, 3, 4, 5],
            [1, 2, 4, 5],
            [1, 2, 3, 5],
            [1, 2, 5],
            [1, 3, 5],
            [1, 4, 5],
            [2, 3, 5],
            [2, 4, 5],
            [3, 4, 5],
            [1, 5],
            [2, 5],
            [3, 5],
            [4, 5]
        ]

        for p in patterns
            csv.push [p.inspect, @population.select {|a| (a._data[:ars] & p) == p}.length]
        end

        addToExport({:name => "viz0bis", :data => csv})
    end

    def vizChina
        csv = [@header_china]

        csv.push(["total", Author.all('participations.institution.country.name' => 'China').length])

        # Working groups
        for wg in 1..3
            csv.push(["WG#{wg}", Author.all('participations.institution.country.name' => 'China', 'participations.wg' => wg).length])
        end

        # ARS
        for ar in 1..5
            csv.push(["AR#{ar}", Author.all('participations.institution.country.name' => 'China', 'participations.ar' => ar).length])
        end

        # Roles
        for role in ['LCA', 'LA', 'RE', 'CA']
            csv.push(["#{role}", Author.all('participations.institution.country.name' => 'China', 'participations.role' => role).length])
        end

        addToExport({:name => "vizChina", :data => csv})
    end

end