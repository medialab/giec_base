# -------------------------------------------------------------------
# Misc Queries
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
        @stacked_participation_header = (1..5).map {|x| "AR#{x}"}

    end

    # Query Execution
    def exec

        # Subparts
        stacked_participations

        return @export
    end

    # Stacked Participations
    def stacked_participations
        csv_authors = [@stacked_participation_header]
        csv_participations = [@stacked_participation_header]

        for wg in 1..3
            row_participations = []
            row_authors = []
            for ar in 1..5
                row_participations.push WGAuthorsIds.getParticipations(ar, wg).length
                row_authors.push WGAuthorsIds.getByAr(ar, wg).length
            end

            csv_participations.push row_participations
            csv_authors.push row_authors
        end

        addToExport({:name => "stacked_wg_participations_per_ar", :data => csv_participations})
        addToExport({:name => "stacked_wg_authors_per_ar", :data => csv_authors})
    end
end