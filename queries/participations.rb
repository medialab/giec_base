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

        # Headers
        @standard_header = ["author_id", "nationality", "institution", "role", "ar", "wg", "chapter"]
        @theme_header = @standard_header + ["theme"]

        # Batches
        @participations = Participation.all(:ar.not => 5)
        @wg1_participations = Participation.all(:wg => 1)
        @roled_participations = Participation.all(:role => ["LA", "CLA"])
    end

    # Query Execution
    def exec

        # Subparts
        standard(@participations, "pop_standard")
        standard(@roled_participations, "pop_roles")
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
                    ct.name
                ])
            end
        end

        addToExport({:name => "themes", :type => :csv, :data => csv})
    end

end