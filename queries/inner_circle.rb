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
        @ic_institutions_header = ["institution_name"] + (2..5).map {|x| "cross#{x}_count"}
        @ic_countries_header = ["country_name"] + (2..5).map {|x| "cross#{x}_count"}
        @ic_participation_per_ar = (1..5).map {|x| "AR#{x}"}
        @ic_themes_header = ["theme"] + @ic_participation_per_ar
        @ic_stars_header = ["author_id", "author_firstname", "author_lastname"] + (1..5).map {|x| ["ar#{x}_institution", "ar#{x}_country"]}.flatten

        # Batches
        @inner_authors = InnerCircle.get
        @stars = @inner_authors[0..49]

        @csv_results = {}
    end

    # Query Execution
    def exec

        # Subparts
        authors
        countries_and_institutions
        participation_per_ars
        stars

        return @csv_results
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

        @csv_results.store("authors", csv)
    end

    # Stars
    def stars
        csv = [@ic_stars_header]

        for aut in @stars
            informations = (1..5).map do |x|
                if aut._data[:participations].include? x
                    institution = aut._data[:participations][x].institution || Institution.new(:name => 'N/A')

                    if institution.country != nil
                        country = institution.country.name
                    else
                        country = 'N/A'
                    end

                    [institution.name, country]
                else
                    ['N/A', 'N/A']
                end
            end

            csv.push([
                aut.id,
                aut.first_name,
                aut.last_name
            ] + informations.flatten)

            @csv_results.store('stars', csv)
        end
    end

    # Country query
    def countries_and_institutions
        countries = {}
        institutions = {}

        # Determining institutions
        for aut in @inner_authors
            
            aut._data[:participations].each_value do |p|
                
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
            institution_csv.push([name] + (2..5).map {|x| counts[x]})
        end

        country_csv = [@ic_countries_header]
        countries.each do |name, counts|
            country_csv.push([name] + (2..5).map {|x| counts[x]})
        end

        @csv_results.store("institutions", institution_csv)
        @csv_results.store("countries", country_csv)
    end

    def participation_per_ars
        ars = {}
        themes = {}
        (1..5).each {|i| ars.store(i, {:authors => 0, :participations => 0})}

        for ct in ChapterType.all
            themes.store(ct.name, {1 => 0, 2 => 0, 3 => 0, 4 => 0, 5 => 0})
        end

        # Retrieving data
        for aut in @inner_authors
            for ar in aut._data[:ars]
                ars[ar][:authors] += 1
                ars[ar][:participations] += aut.participations.length

                for p in aut.participations
                    chapter = Chapter.first(:wg => p.wg, :ar => p.ar, :number => p.chapter)
                    
                    if chapter != nil
                        for ct in chapter.types
                            themes[ct.name][ar] += 1
                        end
                    end
                end
            end
        end

        # Formatting csv array
        authors_csv = [@ic_participation_per_ar]
        participation_csv = [@ic_participation_per_ar]
        themes_csv = [@ic_themes_header]

        authors_csv.push((1..5).map {|x| ars[x][:authors]})
        participation_csv.push((1..5).map {|x| ars[x][:participations]})

        themes.each do |theme, participations|
            themes_csv.push([theme] + (1..5).map {|x| participations[x]} )
        end

        @csv_results.store("authors_per_ar", authors_csv)
        @csv_results.store("participations_per_ar", participation_csv)
        @csv_results.store("themes_per_ar", themes_csv)
    end

end