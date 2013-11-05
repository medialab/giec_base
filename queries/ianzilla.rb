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

        # Model
        @themes = ChapterType.all
        @countries = Country.all

        # Headers
        @header = ["id", "first_name", "last_name", "participations (AR.WG)", "WGS count", "last_institution", "pays", "LCA", "LA", "RE", "CA"]
        @header2 = ["country"] + @themes.map {|t| t.name}    
    end

    # Query Execution
    def exec

        # Subparts
        # addToExport({:data => ianzilla, :name => "ianzilla"})
        # addToExport({:data => everyone, :name => "everyone"})
        addToExport({:data => ianzilla2, :name => "ianzilla2"})
        ianzilla2
        return @export
    end

    # Everyone
    def everyone
        csv = [["id", "first_name", "last_name"]]

        for a in Author.all
            row = [a.id, a.first_name, a.last_name]
            csv.push row
        end

        return csv
    end

    # Query
    def ianzilla
        csv = [@header]

        authors = CrossWGAuthors.get

        for a in authors

            # Last institution
            last_institution = a.institutions.last

            # Participations
            pstring = ''
            for wg in a._data[:wgs]
                ps = []
                for ar in 1..5
                    arp = Participation.first(:author_id => a.id, :wg => wg, :ar => ar)
                    if arp != nil
                        ps.push ar
                    end
                end
                pstring << "WG#{wg} => ARS(#{ps.join(',')}) "
            end
            

            row = [
                a.id,
                a.first_name,
                a.last_name,
                pstring,
                a._data[:wgs].length,
                "(#{last_institution.type.symbol}) #{last_institution.name}",
                last_institution.country.name,
                la = (Participation.first(:author_id => a.id, :role => 'LA') != nil) ? 'yes' : 'no',
                cla = (Participation.first(:author_id => a.id, :role => 'LCA') != nil) ? 'yes' : 'no',
                re = (Participation.first(:author_id => a.id, :role => 'RE') != nil) ? 'yes' : 'no',
                ca = (Participation.first(:author_id => a.id, :role => 'CA') != nil) ? 'yes' : 'no',
            ]

            csv.push rowgmail

        end

        return csv
    end

    # Query 2
    def ianzilla2
        csv = [@header2]

        for c in @countries
            row = [c.name]
            for t in @themes
                chs = t.chapters
                pl = 0
                for ch in t.chapters
                    pl += Participation.all('institution.country.name' => c.name, :ar => ch.ar, :wg => ch.wg, :chapter => ch.number).length
                end
                row.push pl
            end
            csv.push row
        end

        return csv
    end

end