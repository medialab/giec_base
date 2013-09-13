# -------------------------------------------------------------------
# Inner Circle Query
# -------------------------------------------------------------------
#
#
#   Author : PLIQUE Guillaume
#   Organization : Medialab - Sciences Po
#   Version : 1.0

require_relative "subqueries.rb"

class Query

    # Base properties definition
    def initialize

        # Headers
        @ic_header = ["author_id", "author_firstname", "author_lastname", "ar_count"]
        @ic_institutions_header = ["institution_name", "2ars_count", "3ars_count", "4ars_count", "5ars_count"]
        @ic_countries_header = ["country_name", "2ars_count", "3ars_count", "4ars_count", "5ars_count"]

        # Batches
        @inner_authors = InnerCircle.get
    end

    # Query Execution
    def exec

        # Subparts
        ic_authors = authors
        ic_institutions, ic_countries = countries_and_institutions

        return {
            "authors" => ic_authors,
            "institutions" => ic_institutions,
            "countries" => ic_countries
        }
    end

    # Authors
    def authors
        csv = [@ic_header]

        for aut in @inner_authors
            csv.push([
                aut.id,
                aut.first_name,
                aut.last_name,
                aut._data[:ars].length
            ])
        end

        return csv
    end

    # Country query
    def countries_and_institutions
        countries = {}
        institutions = {}

        # Determining institutions
        for aut in @inner_authors
            
            for p in aut._data[:participations]
                
                # Regularization
                if p.institution == nil then p.institution = Institution.new(:name => "N/A", :id => 0) end         

                # Storage
                institutions[p.institution.name] ||= {2 => 0, 3 => 0, 4 => 0, 5 => 0}
                for i in 2..aut._data[:ars].length
                    institutions[p.institution.name][i] += 1
                end

                if p.institution.country != nil
                    country = p.institution.country.name
                    countries[country] ||= {2 => 0, 3 => 0, 4 => 0, 5 => 0}
                    for i in 2..aut._data[:ars].length
                        countries[country][i] += 1
                    end
                end
            end
        end

        # Formatting csv array
        institution_csv = [@ic_institutions_header]
        institutions.each do |name, counts|
            institution_csv.push([
                name,
                counts[2],
                counts[3],
                counts[4],
                counts[5]
            ])
        end

        country_csv = [@ic_countries_header]
        countries.each do |name, counts|
            country_csv.push([
                name,
                counts[2],
                counts[3],
                counts[4],
                counts[5]
            ])
        end

        return institution_csv, country_csv
    end

end