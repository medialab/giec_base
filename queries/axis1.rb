# -------------------------------------------------------------------
# Axis 1 Query
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

        # Taxonomies
        @geo_groups = Taxonomies::Groups.select {|g| g[:type] == "GEO"}
        @geo_symbols = @geo_groups.map {|g| g[:symbol]}

        # Headers
        @vizA_header = ["population"] + @geo_groups.map {|g| g[:name]}
    end

    # Query Execution
    def exec

        # Subparts
        viz('vizA', CrossARAuthors.get, CrossARAuthors.getByRoles)
        viz('vizB', CrossARAuthors.get(1), CrossARAuthors.getByRoles(1))

        return @export
    end

    # Viz A & B
    def viz(name, total_population, roled_population)
        csv = [@vizA_header]

        for i in 1..5
            csv.push get_row("total population for min AR count #{i}", total_population, i)
            csv.push get_row("total population for min AR count #{i} (LA, LCA, RE)", roled_population, i)
        end

        addToExport({:name => name, :data => csv})
    end

    def get_row(description, population, ar_count)
        group_counts = {}
        @geo_groups.map {|g| group_counts.store(g[:symbol], 0)}

        for a in population.select {|a| a._data[:ars].length >= ar_count}
            if a.institutions.length > 0
                if a.institutions[-1].country != nil
                    for gp in a.institutions[-1].country.groupings
                        if @geo_symbols.include?(gp.symbol)
                            group_counts[gp.symbol] += 1
                        end
                    end
                end
            end
        end

        return [description] + group_counts.values
    end

end