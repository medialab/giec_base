# -------------------------------------------------------------------
# Inner Circle Query
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
        @ic_definitions_header = ["definition"] + (1..3).map {|i| "WG#{i}"} + ["description"]
        @ic_stars_header = ["author_id", "author_name", "last_country", "last_institution", "ar_count"]
        
        # Batches
        @inner_authors = []
        @stars = @inner_authors[0..49]

    end

    # Query Execution
    def exec

        # Subparts
        innerCircleDefinitions

        return @export
    end

    # Inner Circle Information
    def innerCircleDefinitions
        csv = [@ic_definitions_header]

        operations = {
            :definition1 => "AR Count > 1",
            :definition2 => "AR Count > 2",
            :definition3 => "AR Count > 1 AND LA OR CLA role",
            :definition4 => "AR Count > 1 AND LA OR CLA role AND at least two chapters in same AR"
        }

        operations.each do |function, description|
            results = [function.to_s]
            for wg in 1..3
                results.push InnerCircle.send(function, wg).length
            end

            csv.push results + [description]
        end

        addToExport({:type => :csv, :name => 'definitions', :data => csv})
    end

    # Stars information
    def stars

        # Looping through stars
        csv = [@ic_stars_header]

        for star in @stars

            if star._data[:participations].values.last.institution != nil
                if star._data[:participations].values.last.institution.country != nil
                    csv.push([
                        star.id,
                        "#{star.first_name} #{star.last_name}",
                        star._data[:participations].values.last.institution.name,
                        star._data[:participations].values.last.institution.country.name,
                        star._data[:ars].length
                    ])
                end
            end
        end

        # Adding to export
        addToExport({:name => 'stars', :type => :csv, :data => csv})
    end

end