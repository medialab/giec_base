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
        @geo_groups = Taxonomies::Groups.select {|g| g[:type] == "WMO"}
        @geo_symbols = @geo_groups.map {|g| g[:symbol]}
        @geo_dict = {}
        @geo_groups.map {|g| @geo_dict.store(g[:symbol], g[:name])}

        # Headers
        @header_vizC = ["geographical_group"] + (1..5).map {|i| "author_count_for_AR#{i}"}
        @header_vizE = ["geographical_group"] + (1..3).map {|i| "author_count_for_WG#{i}"}
        @header_vizF = ["population"] + (1..5).map {|i| "author_count_AR#{i}"}
        @header_vizG = ["geographical_symbol", "geographical_group", "country", "participation_count"]
    end

    # Query Execution
    def exec

        # Subparts
        # vizC
        # vizD
        # vizE
        # vizF
        vizG
        # vizJ

        return @export
    end

    def vizC
        csv = [@header_vizC]

        for geo in @geo_groups
            row = [geo[:name]]

            # Getting count
            institutions = Institution.all('country.groupings.symbol' => geo[:symbol]).map {|i| i.id}
            for ar in 1..5
                row.push repository(:default).adapter.select("SELECT DISTINCT author_id from participations WHERE ar = #{ar} AND institution_id IN (#{institutions.join(',')})").length
            end

            csv.push row
        end

        addToExport({:name => 'vizC', :data => csv})
    end

    def vizD
        csv = [@header_vizC]

        for geo in @geo_groups
            row = [geo[:name]]

            # Getting count
            institutions = Institution.all('country.groupings.symbol' => geo[:symbol]).map {|i| i.id}
            for ar in 1..5
                row.push repository(:default).adapter.select("SELECT DISTINCT author_id from participations WHERE ar = #{ar} AND role IN ('LA', 'LCA', 'RE') AND institution_id IN (#{institutions.join(',')})").length
            end

            csv.push row
        end

        addToExport({:name => 'vizD', :data => csv})
    end

    def vizE
        csv = [@header_vizE]

        for geo in @geo_groups
            row = [geo[:name]]

            # Getting count
            institutions = Institution.all('country.groupings.symbol' => geo[:symbol]).map {|i| i.id}
            for wg in 1..3
                row.push repository(:default).adapter.select("SELECT DISTINCT author_id from participations WHERE wg = #{wg} AND institution_id IN (#{institutions.join(',')})").length
            end

            csv.push row
        end

        addToExport({:name => 'vizE', :data => csv})
    end

    def vizF
        csv = [@header_vizF]

        for geo in @geo_groups
            row_new = ["#{geo[:name]} new authors"]
            row_old = ["#{geo[:name]} old authors"]
            authors = CrossARAuthors.getByGeo(geo[:symbol])

            checked_ars = []
            for ar in 1..5
                checked_ars.push ar
                row_new.push authors.select {|a|  a._data[:ars][0] == ar}.length
                row_old.push authors.select {|a| a._data[:ars][0] != ar && a._data[:ars].include?(ar)}.length
            end

            csv.push row_new
            csv.push row_old
        end

        addToExport({:name => 'vizF', :data => csv})
    end

    def vizG
        csv = [@header_vizG]

        for c in Country.all
            row = [
                c.groupings.select {|g| @geo_symbols.include?(g.symbol)}[0].symbol,
                @geo_dict[c.groupings.select {|g| @geo_symbols.include?(g.symbol)}[0].symbol],
                c.name
            ]
            institutions = c.institutions.map {|i| i.id}
            
            row.push repository(:default).adapter.select("SELECT author_id from participations WHERE institution_id IN (#{institutions.join(',')})").length
            csv.push row
        end

        addToExport({:name => 'vizG', :data => csv})
    end

    def vizJ
        csv = [@header_vizC]

        for geo in @geo_groups
            row = [geo[:name]]

            # Getting count
            institutions = Institution.all('country.groupings.symbol' => geo[:symbol]).map {|i| i.id}
            for ar in 1..5
                row.push repository(:default).adapter.select("SELECT author_id from participations WHERE ar = #{ar} AND institution_id IN (#{institutions.join(',')})").length
            end

            csv.push row
        end

        addToExport({:name => 'vizJ', :data => csv})
    end
end