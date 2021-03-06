# -------------------------------------------------------------------
# Participations Query
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

        # Taxonomies
        @geo_groups = Taxonomies::Groups.select {|g| g[:type] == "WMO"}
        @geo_symbols = @geo_groups.map {|g| g[:symbol]}
        @geo_dict = {}
        @geo_groups.map {|g| @geo_dict.store(g[:symbol], g[:name])}

        # Headers
        @standard_header = ["author_id", "nationality", "institution", "role", "ar", "wg", "chapter"]
        @theme_header = @standard_header + ["theme", "group_symbol", "group_name"]

        # Batches
        @participations = Participation.all(:ar.not => 5)
        @wg1_participations = Participation.all(:wg => 1)
        @roled_participations = Participation.all(:role => ["LA", "LCA"])
    end

    # Query Execution
    def exec

        # Subparts
        standard(@participations, "participations_pop_standard")
        standard(@roled_participations, "participations_pop_roles")
        themes

        return @export
    end

    def standard(batch, name)
        csv = [@standard_header]

        for p in batch

            p.institution ||= Institution.new(:name => 'N/A')
            p.institution.country ||= Country.new(:name => 'N/A')

            csv.push([
                p.author_id,
                p.institution.country.name,
                p.institution.name,
                p.role,
                p.ar,
                "#{p.ar}.#{p.wg}",
                "#{p.ar}.#{p.wg}.#{p.chapter}"
            ])
        end

        addToExport({:name => name, :type => :csv, :data => csv})
    end

    def themes
        csv = [@theme_header]

        for p in @wg1_participations

            p.institution ||= Institution.new(:name => 'N/A')
            p.institution.country ||= Country.new(:name => 'N/A')

            group_symbol = p.institution.country.groupings.length > 0 ? p.institution.country.groupings.select {|g| @geo_symbols.include?(g.symbol)}[0].symbol : 'N/A'
            group_name = p.institution.country.groupings.length > 0 ? @geo_dict[p.institution.country.groupings.select {|g| @geo_symbols.include?(g.symbol)}[0].symbol] : 'N/A'

            chapter = Chapter.first(:number => p.chapter, :wg => p.wg, :ar => p.ar)

            for ct in chapter.types
                csv.push([
                    p.author_id,
                    p.institution.country.name,
                    p.institution.name,
                    p.role,
                    p.ar,
                    "#{p.ar}.#{p.wg}",
                    "#{p.ar}.#{p.wg}.#{p.chapter}",
                    ct.name,
                    group_symbol,
                    group_name
                ])
            end
        end

        addToExport({:name => "participations_themes", :type => :csv, :data => csv})
    end

end