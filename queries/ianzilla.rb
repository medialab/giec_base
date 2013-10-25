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

        # Headers
        @header = ["id", "first_name", "last_name", "participations (AR.WG)", "WGS count", "last_institution", "pays"]
    end

    # Query Execution
    def exec

        # Subparts
        # addToExport({:data => ianzilla, :name => "ianzilla"})
        addToExport({:data => everyone, :name => "everyone"})
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
    # def ianzilla
    #     csv = [@header]

    #     authors = CrossWGAuthors.get

    #     for a in authors

    #         # Last institution
    #         last_institution = a.institutions.last

    #         # Participations
    #         pstring = ''
    #         for wg in a._data[:wgs]
    #             ps = []
    #             for ar in 1..5
    #                 arp = Participation.first(:author_id => a.id, :wg => wg, :ar => ar)
    #                 if arp != nil
    #                     ps.push ar
    #                 end
    #             end
    #         end
    #         pstring << "WG#{wg} => ARS(#{ps.join(',')})"

    #         row = [
    #             a.id,
    #             a.first_name,
    #             a.last_name,
    #             pstring,
    #             a._data[:wgs].length,
    #             "(#{last_institution.type.symbol}) #{last_institution.name}",
    #             last_institution.country.name
    #         ]

    #         csv.push row
    #     end

    #     return csv
    # end

end