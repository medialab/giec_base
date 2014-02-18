# -------------------------------------------------------------------
# Holes Query
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
        @header = [
            'modified',
            'id',
            'first_name',
            'last_name',
            'AR',
            'WG',
            'chapters',
            'roles',
            'institution',
            'institution_type',
            'country',
            'groupings'
        ]
    end

    # Query Execution
    def exec

        # Subparts
        addToExport({:data => holes, :name => "holes"})
        return @export
    end

    # Query
    def holes
        csv = [@header]

        # Iterating through authors
        c = 0
        for a in Author.all
            c += 1
            puts "#{c} - #{a.first_name} #{a.last_name}"

            # Iterating through ARs
            for ar in 1..5

                # Get participations for ar
                ps = Participation.all(:ar => ar, :author => a)
                
                if ps.length > 0
                    csv.push [
                        '',
                        a.id,
                        a.first_name,
                        a.last_name,
                        ar,
                        ps.map {|p| p.wg}.uniq.join(','),
                        ps.map {|p| "wg#{p.wg}.#{p.chapter}"}.join('|'),
                        ps.map {|p| p.role}.uniq.join(','),
                        ps.first.institution.name,
                        ps.first.institution.type.name,
                        ps.first.institution.country.name,
                        ps.first.institution.country.groupings.map {|g| g.symbol}.join(', '),
                    ]
                end
            end
        end

        return csv
    end
end
